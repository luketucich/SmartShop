//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Luke on 10/16/25.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    var body: some Scene {
        WindowGroup {
                HomeScreen()
            }.environment(\.authenticationController, .development)
        }
    }

