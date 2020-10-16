//
//  SecurityService.swift
//  InvoiceManager
//
//  Created by Tianid on 16.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case notGetAllData
}

class SecurityService {
    private var coreDataManager: ICoreDataManager?
    static let shared = SecurityService()
    
    private init() { }
    
    static func setCoreDataManager(coreDataManager: ICoreDataManager) {
        shared.coreDataManager = coreDataManager
    }
    
    private static func encodeToJSON() -> Result<String?, JSONError> {
        guard let invoices = shared.coreDataManager?.fetchAllInvoicesWithAllBills(predicate: nil, sortDescriptors: nil, isUsedBackgroundContext: false), !invoices.isEmpty else { return .failure(.notGetAllData) }
        do {
            let jsonData = try JSONEncoder().encode(invoices)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return .success(jsonString)
        } catch {
            print(error)
            return .failure(.notGetAllData)
        }
    }
    
    private static func decodeFromJSON(data: Data) -> Result<[Invoice], JSONError> {
        do {
            let data = try JSONDecoder().decode([Invoice].self, from: data)
            return .success(data)
        } catch {
            print(error)
            return .failure(.notGetAllData)
        }
    }
    
    static func encryptBackup(password: String) -> Result<String?, JSONError> {
        let json = encodeToJSON()
        // SOME ENCRYPTION
        
        return json
    }
    
    static func decryptBackup(password: String, data: Data) -> Result<[Invoice], JSONError> {
        guard let encryptedString = String(data: data, encoding: .utf8) else { return .failure(.notGetAllData) }
        //SOME DECRYPTION
//        let decryptedString = SOME DESCRYPTED FUNC foo(encryptedString: encryptedString)
//        let data = decryptedString.data(using: .utf8)
        
       return decodeFromJSON(data: data)
    }
}
