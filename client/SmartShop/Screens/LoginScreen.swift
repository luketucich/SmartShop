//
//  LoginScreen.swift
//  client
//
//  Created by Luke on 10/18/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = "Jump back in and continue shopping"
    @State private var messageColor: Color = .gray
    
    @AppStorage("userId") private var userId: Int?
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async{
        do {
            let response = try await authenticationController.login(username: username, password: password)
            
            if response.success {
                let token = response.token
                let userId = response.userId
                
                message = response.message ?? "Login successful"
                messageColor = .green
                
                // set userId in user defaults
                self.userId = userId
                
                // set token in keychain
                Keychain.set(token, forKey: "jwttoken")
            } else {
                message = response.message ?? "Request cannot be completed"
                messageColor = .red
            }
        } catch {
            message = error.localizedDescription
            messageColor = .red
        }
        
        username = ""
        password = ""
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text("Login")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            Text(message)
                .font(.subheadline)
                .foregroundColor(messageColor)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
                        
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
                        
            Button("Submit"){
                Task {
                    await login()
                }
            }
                .padding()
                .background(isFormValid ? Color.blue : Color.secondary)
                .foregroundColor(Color.white)
                .disabled(!isFormValid)
                .cornerRadius(10)
                .frame(maxWidth: 300)
        }.padding(.horizontal, 50 )
        
            .navigationDestination(item: $userId, destination: {_ in Text("Home Screen")
            })
    }
}

#Preview {
    NavigationStack{
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
