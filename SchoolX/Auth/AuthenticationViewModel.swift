//
//  AuthenticationViewModel.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
        
    func signUpEmail(email: String, password: String, name: String) async throws {
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        var userModel = UserModel(auth: authDataResult)
        userModel.name = name
        try await UserManager.shared.createNewUser(user: userModel)
        
    }
    
    func signInEmail(email: String, password: String) async throws -> UserModel {
        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func signInGoogle() async throws -> UserModel {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func signInApple() async throws -> UserModel {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        return try await UserManager.shared.getUser(userId: authDataResult.uid)
    }

}
