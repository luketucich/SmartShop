//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Luke on 10/16/25.
//

import SwiftUI

@main
struct SmartShopApp: App {
    
    @State private var token: String?
    @State private var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                Group {
                    if isLoading {
                        ProgressView("Loading...")
                    } else {
                        if TokenValidator.validate(token: token){
                            Text("HomeScreen")
                        } else {
                            LoginScreen()
                        }
                    }
                }

            }.environment(\.authenticationController, .development)
                .onAppear(perform: {
                    token = Keychain.get("jwttoken")
                    isLoading = false
                })
        }
    }
}
