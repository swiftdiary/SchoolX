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
    
    @discardableResult
    func signInEmail(email: String, password: String) async throws -> UserModel {
        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        return user
    }
    
    @discardableResult
    func signInGoogle() async throws -> UserModel {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        do {
            let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            return user
        } catch {
            let user = UserModel(auth: authDataResult)
            do {
                try await UserManager.shared.createNewUser(user: user)
            } catch {
                print(error)
            }
            return user
        }
    }
    
    @discardableResult
    func signInApple() async throws -> UserModel {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        do {
            let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            return user
        } catch {
            let user = UserModel(auth: authDataResult)
            do {
                try await UserManager.shared.createNewUser(user: user)
            } catch {
                print(error)
            }
            return user
        }
//        let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//        try await UserManager.shared.createNewUser(user: user)
//        return user
    }

    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
}
