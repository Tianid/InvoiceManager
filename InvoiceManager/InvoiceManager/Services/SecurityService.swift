//
//  SecurityService.swift
//  InvoiceManager
//
//  Created by Tianid on 16.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import Locksmith
import AESCryptable
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

enum JSONError: String, Error {
    case notGetAllData
    case noDataInStorage = "Storage is empty"
    case JSONEncodeError
    case JSONDecodeError
    case PasswordError = "Wrong password"
}

class SecurityService {
    private var coreDataManager: ICoreDataManager?
    static let shared = SecurityService()
    
    private init() { }
        
    private static func encodeToJSON() -> Result<String?, JSONError> {
        guard let invoices = shared.coreDataManager?.fetchAllInvoicesWithAllBills(predicate: nil, sortDescriptors: nil, isUsedBackgroundContext: false), !invoices.isEmpty else { return .failure(.noDataInStorage) }
        do {
            let jsonData = try JSONEncoder().encode(invoices)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return .success(jsonString)
        } catch {
            print(error)
            return .failure(.JSONEncodeError)
        }
    }
    
    private static func decodeFromJSON(data: Data) -> Result<[Invoice], JSONError> {
        do {
            let data = try JSONDecoder().decode([Invoice].self, from: data)
            return .success(data)
        } catch {
            print(error)
            return .failure(.JSONDecodeError)
        }
    }
    
    private static func encrypt(key: String, string: String) -> Result<Data, Error> {
        do {
            let aes = try AES(keyString: key)
            let encryptedData = try aes.encrypt(string)
            return .success(encryptedData)
        } catch {
            return .failure(error)
        }
    }
    
    private static func decrypt(key: String, encryptedData: Data) -> String? {
        do {
            let aes = try AES(keyString: key)
            let decryptedString = try aes.decrypt(encryptedData)
            return decryptedString
            
        } catch {
            print(error)
            return nil
        }
    }
    
    private static func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    private static func MD5Hex(string: String) -> String {
        let md5Data = MD5(string: string)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
    static func setCoreDataManager(coreDataManager: ICoreDataManager) {
        shared.coreDataManager = coreDataManager
    }
    
    static func encryptBackup(password: String) -> Result<Data, Error> {
        let result = encodeToJSON()
        
        switch result {
        case .success(let string):
            guard let json = string else { return .failure(JSONError.JSONEncodeError)}
            let key = MD5Hex(string: password)
            return encrypt(key: key, string: json)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func decryptBackup(password: String, data: Data) -> Result<[Invoice], JSONError> {
        let key = MD5Hex(string: password)
        let result = decrypt(key: key, encryptedData: data)
        guard let decryptedString = result else { return .failure(.PasswordError)}
        guard let data = decryptedString.data(using: .utf8) else { return .failure(.notGetAllData)}
        return decodeFromJSON(data: data)
    }
    
    static func dropCoreData(successor: (() -> ())?, failure: (() -> ())? = nil) {
        guard let result = shared.coreDataManager?.dropCoreData() else { return }
        switch result {
        case .success(_):
            successor?()
        case .failure(_):
            failure?()
        }
    }
    
    static func importBackup(models: [Invoice], complition: (() -> ())? ) {
        dropCoreData(successor: {
            guard let result = shared.coreDataManager?.importData(data: models) else { return }
            switch result {
            case .success(_):
                complition?()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    //MARK: - Keychain func
    static func saveRecordIntoKeychain(data: [String: Any], for userAccount: String) -> Result<Void, Error> {
        do {
            try Locksmith.saveData(data: data, forUserAccount: userAccount)
            return .success(())
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    static func updateRecordInKeychain(data: [String: Any], for userAccount: String) -> Result<Void, Error> {
        do {
            try Locksmith.updateData(data: data, forUserAccount: userAccount)
            return .success(())
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    static func deleteRecordInKeychain(for userAccount: String) -> Result<Void, Error> {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
            return .success(())
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    static func selectRecordFromKeychaint(for userAccount: String) -> [String: Any]? {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: userAccount)
        return dictionary
    }
    
    static func isPasscodeSet() -> (isPasscodeSet:Bool, data: (type: Int, passcode: String?)?) {
        let userDefaults = UserDefaults.standard
        var type = 0
        var passcode: String? = nil
        
        let isPasscodeSet = userDefaults.bool(forKey: requireCurrentPasscodeConst)
        if isPasscodeSet {
            type = userDefaults.integer(forKey: passcodeTypeConst)
            let dict = SecurityService.selectRecordFromKeychaint(for: keychainAccountConst)
            passcode = dict?[keychainPasscodeConst] as? String
            return (isPasscodeSet, data: (type: type, passcode: passcode))
        }
        return (isPasscodeSet: isPasscodeSet, data: nil)
    }
}
