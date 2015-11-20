//
//  KeyChainStore.swift
//  TouchyFeely
//
//  Created by WJ on 15/11/20.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import Security

protocol SecureStore{
    var secret :String?{ get set}
}

class  KeyChainStore: SecureStore{
    var serviceIdentifier = "TouchyFeelySecureStore"
    var accountName = "TouchyFeelyAccount"
    
    var secret:String?{
        get{
            return load()
        }
        set{
            if let newValue = newValue{
                save(newValue)
            }else{
                delete()
            }
        }
    }
    
    // MARK:- Utility methods
    private func save(token:String){
        if let data = token.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false){
            delete()
            
            let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .UserPresence, nil)
            
            let keyChainQuery = [
                kSecClass as String          :kSecClassGenericPassword,
                kSecAttrService as String    :serviceIdentifier,
                kSecAttrAccount as String    :accountName,
                kSecValueData as String      :data,
                kSecAttrAccessControl as String:accessControl!
            ]
            SecItemAdd(keyChainQuery, nil)
        }
    }
    
    private func load()->String?{
        let keyChainQuery = [
            kSecClass as String               :kSecClassGenericPassword,
            kSecAttrService as String         :serviceIdentifier,
            kSecAttrAccount as String         :accountName,
            kSecReturnData as String          :true,
            kSecMatchLimit as String          :kSecMatchLimitOne,
            kSecUseOperationPrompt as String  :"Authenticate to retrieve your secret!"
        ]
        var extractedData: AnyObject?
        var contentsOfKeychain:String?
        
        let status = SecItemCopyMatching(keyChainQuery, &extractedData)
        if status == errSecSuccess{
            let retrievedData = extractedData as? NSData
            contentsOfKeychain = NSString(data: retrievedData!, encoding: NSUTF8StringEncoding) as? String
        }else{
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return contentsOfKeychain
    }
    
    private func delete(){
        let keyChainQuery = [
            kSecClass  as String:kSecClassGenericPassword,
            kSecAttrService as String :serviceIdentifier,
            kSecAttrAccount as String :accountName
        ]
        SecItemDelete(keyChainQuery)
    }
}
