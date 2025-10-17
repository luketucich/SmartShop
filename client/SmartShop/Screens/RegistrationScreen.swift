//
//  RegistrationScreen.swift
//  client
//
//  Created by Luke on 10/16/25.
//

import SwiftUI

struct RegistrationScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            TextField("User name", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
        }.navigationTitle(Text("Register"))
    }
}

#Preview {
    NavigationStack{
        RegistrationScreen()
    }
}
