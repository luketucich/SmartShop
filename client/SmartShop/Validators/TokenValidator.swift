//
//  TokenValidator.swift
//  SmartShop
//
//  Created by Luke on 10/19/25.
//

import Foundation
import JWTDecode

struct TokenValidator{
    
    static func validate(token: String?) -> Bool {
        
        guard let token = token else { return false }
        
        do {
            let jwt = try decode(jwt: token)
            
            if let expirationDate = jwt.expiresAt {
                let currentDate = Date()
    
                return expirationDate > currentDate
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
