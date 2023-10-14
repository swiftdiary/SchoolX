//
//  Utils.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import Foundation
import UIKit

class Utils {
    static let shared = Utils()
    private init() { }
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func checkPassword(_ password: String) -> String {
        if password.count < 8 {
            return "Password should contain more than 8 digits!!"
        } else if !stringHasNumber(password) {
            return "Password should contain numbers!!"
        } else if !stringHasUpperCased(password) {
            return "Password should contain Uppercased letters!!!"
        }
        return ""
    }
    
    func stringHasNumber(_ string:String) -> Bool {
        for character in string{
            if character.isNumber{
                return true
            }
        }
        return false
    }
    
    func stringHasUpperCased(_ string:String) -> Bool {
        for character in string{
            if character.isUppercase{
                return true
            }
        }
        return false
    }
    
}
