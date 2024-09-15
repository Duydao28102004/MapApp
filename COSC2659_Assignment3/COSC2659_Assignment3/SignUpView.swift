//
//  ContentView.swift
//  COSC2659_Assignment3
//
//  Created by Bảo Duy Đào on 13/9/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var profileImage: Image? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            // Title and Subtitle
            Text("SafePath Vietnam welcomes you!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            Text("Your Path to Safer Roads")
                .font(.subheadline)
                .italic()
                .foregroundColor(.gray)
            
            // Input Fields
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                TextField("Your Displayed Name", text: $displayName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                SecureField("Re-enter your password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                // Profile Image Picker (Placeholder)
                Button(action: {
                    // Action to upload a profile image
                }) {
                    HStack {
                        Text("Select a profile image")
                        Spacer()
                        Image(systemName: "arrow.up.circle.fill")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(.horizontal)
            
            // Terms and Conditions Checkbox
            HStack {
                Toggle(isOn: .constant(true)) {
                    Text("By checking the box you agree to our")
                }
                .toggleStyle(CheckboxToggleStyle())
                
                Button(action: {
                    // Action to show terms and conditions
                }) {
                    Text("Terms and Conditions.")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            // Sign Up Button
            Button(action: {
                // Action for Sign Up
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            // Log In Link
            HStack {
                Text("Already a member?")
                Button(action: {
                    // Action for Log In
                }) {
                    Text("Log In Here")
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
    SignUpView()
}
