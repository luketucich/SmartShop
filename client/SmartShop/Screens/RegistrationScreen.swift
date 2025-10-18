//
//  RegistrationScreen.swift
//  client
//
//  Created by Luke on 10/16/25.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    @Environment(\.dismiss) private var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = "Create your account to get started"
    @State private var messageColor: Color = .gray
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func register() async{
        do {
            let response = try await authenticationController.register(username: username, password: password)
            
            if response.success {
                message = response.message ?? ""
                messageColor = .green
                
                dismiss()
            } else {
                message = response.message ?? ""
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
            Text("Register")
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
                    await register()
                }
            }
                .padding()
                .background(isFormValid ? Color.blue : Color.secondary)
                .foregroundColor(Color.white)
                .disabled(!isFormValid)
                .cornerRadius(10)
                .frame(maxWidth: 300)
        }.padding(.horizontal, 50 )
    }
}

#Preview {
    NavigationStack{
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}
