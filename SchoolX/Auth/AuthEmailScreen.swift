//
//  AuthEmailScreen.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI

struct AuthEmailScreen: View {
    @State private var segmentPickerValue: Bool = false
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var password: String = ""
    @State private var isAlertPresented: Bool = false
    @State private var alertMessage: String = "" { didSet {
        if !alertMessage.isEmpty {
            withAnimation(.bouncy) {
                isAlertPresented = true
            }
        }
    }}
    @EnvironmentObject private var appNavigation: AppNavigation
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(maxHeight: 600)
                .padding()
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    SignInContent()
                }
                .animation(.bouncy, value: segmentPickerValue)
        }
        .alert(alertMessage, isPresented: $isAlertPresented) {
            Button("Ok") {
                withAnimation(.bouncy) {
                    alertMessage = ""
                }
            }
        }
    }
    
    @ViewBuilder func SignInContent() -> some View {
        ScrollView {
            VStack {
                Picker(selection: $segmentPickerValue) {
                    Text("Sign Up")
                        .tag(false)
                    Text("Sign In")
                        .tag(true)
                } label: {}
                    .labelsHidden()
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .padding(.top, 30)
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
                        UISegmentedControl.appearance().backgroundColor = .white
                        let colors: [NSAttributedString.Key: Any] = [
                            .foregroundColor : UIColor.white
                        ]
                        UISegmentedControl.appearance().setTitleTextAttributes(colors, for: .selected)
                    }
                
                VStack {
                    ZStack {
                        Text("Sign Up")
                            .opacity(segmentPickerValue ? 0 : 1)
                            .animation(.spring(duration: 0.1), value: segmentPickerValue)
                        Text("Sign In")
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
                        Task {
                            do {
                                if segmentPickerValue {
                                    _ = try await viewModel.signInEmail(email: userEmail, password: password)
                                    withAnimation(.bouncy) {
                                        appNavigation.path = [.home]
                                    }
                                } else {
                                    try await viewModel.signUpEmail(email: userEmail, password: password, name: userName)
                                    withAnimation(.bouncy) {
                                        appNavigation.path = [.home]
                                    }
                                }
                            } catch {
                                alertMessage = Utils.shared.checkPassword(password)
                            }
                        }
                    }, label: {
                        Text(segmentPickerValue ? "Sign In" : "Sign Up")
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
        .scrollDismissesKeyboard(.immediately)
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
            
            SecureField("Password", text: $password)
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
            
            SecureField("Password", text: $password)
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
