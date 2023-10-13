//
//  AuthEmailScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct AuthEmailScreen: View {
    @State var segmentPickerValue: Bool = false
    @State var userName: String = ""
    @State var userEmail: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            //background
            
            
            //content
            RoundedRectangle(cornerRadius: 25.0)
                .frame(maxHeight: 600)
                .padding()
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    SignInContent()
                }
                .animation(.bouncy, value: segmentPickerValue)
        }
    }
    
    @ViewBuilder func SignInContent() -> some View {
        VStack {
            Picker(selection: $segmentPickerValue) {
                Text("Sign In")
                    .tag(false)
                Text("Sign Up")
                    .tag(true)
            } label: {}
                .labelsHidden()
                .pickerStyle(.segmented)
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
                .padding(.top, 30)
            
            VStack {
                ZStack {
                    Text("Sign In")
                        .opacity(segmentPickerValue ? 0 : 1)
                        .animation(.spring(duration: 0.1), value: segmentPickerValue)
                    Text("Sign Up")
                        .opacity(segmentPickerValue ? 1 : 0)
                        .animation(.spring(duration: 0.1), value: segmentPickerValue)
                        
                }
                .font(.title.bold())
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
                
                
                ZStack {
                    SignInComponents()
                        .opacity(segmentPickerValue ? 0 : 1)
                        .animation(.spring(duration: 0.2), value: segmentPickerValue)
                
                    SignUpComponents()
                        .opacity(segmentPickerValue ? 1 : 0)
                        .animation(.spring(duration: 0.2), value: segmentPickerValue)
                }
                
                
                Button(action: {
                    
                }, label: {
                    Text(segmentPickerValue ? "Sign Up" : "Sign In")
                        .animation(.spring(duration: 0.1), value: segmentPickerValue)
                        .font(.headline)
                        .foregroundStyle(Color(UIColor.secondarySystemBackground))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                })
                .padding(.vertical, 40)
                
                
                
            }
            Spacer()
        }
        .animation(.spring(duration: 0.5), value: segmentPickerValue)
        .padding(30)
    }
    
    @ViewBuilder func SignUpComponents() -> some View {
        VStack(spacing: 15) {
            TextField("Email", text: $userEmail)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.accentColor)
                )
                .background(Color.white.cornerRadius(20))
            
            Divider()
            
            TextField("Password", text: $password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.accentColor)
                )
                .background(Color.white.cornerRadius(20))

            
            Text("Forget Password?")
                .font(.caption)
                .foregroundStyle(Color.accentColor)
                .onTapGesture { 
                    //forgot password
                }
        }
        .animation(.none, value: segmentPickerValue)
    }
    
    @ViewBuilder func SignInComponents() -> some View {
        VStack(spacing: 15, content: {
            TextField("Name", text: $userName)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.accentColor)
                )
                .background(Color.white.cornerRadius(20))
            
            Divider()
            
            TextField("Email", text: $userEmail)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.accentColor)
                )
                .background(Color.white.cornerRadius(20))
            
            Divider()
            
            TextField("Password", text: $password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.accentColor)
                )
                .background(Color.white.cornerRadius(20))
        })
        .padding(.vertical)
        .animation(.none, value: segmentPickerValue)
    }
}

#Preview {
    AuthEmailScreen()
}
