//
//  ProfileScreen.swift
//  SmartShop
//
//  Created by Luke on 10/22/25.
//

import SwiftUI

struct ProfileScreen: View {
    
    @AppStorage("userId") private var userId:Int?
    
    var body: some View {
        Button("Sign Out"){
            let _ = Keychain<String>.delete("jwttoken")
            userId = nil
        }
    }
}

#Preview {
    ProfileScreen()
}
