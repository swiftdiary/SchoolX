//
//  ARManager.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 15/10/23.
//

import Foundation
import Combine
import SwiftUI

enum ARAction {
    case placeBlock(color: Color)
    case removeAllAnchors
}

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) { }
}
