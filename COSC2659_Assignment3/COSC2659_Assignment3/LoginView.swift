//
//  ContentView.swift
//  COSC2659_Assignment3
//
//  Created by Bảo Duy Đào on 13/9/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Placeholder for App Logo (Replace with actual Image)
            Image(systemName: "app.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .padding(.top, 50)
            
            Text("SafePath Vietnam")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("Your Path to Safer Roads")
                .font(.subheadline)
                .italic()
                .foregroundColor(.gray)
            
            // Username and Password Fields
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)
            
            // Remember Me and Forgot Password
            HStack {
                Toggle(isOn: $rememberMe) {
                    Text("Remember me")
                }
                .toggleStyle(CheckboxToggleStyle())
                
                Spacer()
                
                Button(action: {
                    // Action for Forgot Password
                }) {
                    Text("Forgot password?")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            // Log In Button
            Button(action: {
                // Action for Log In
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            // Sign Up Link
            HStack {
                Text("New member?")
                Button(action: {
                    // Action for Sign Up
                }) {
                    Text("Sign Up Here")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
