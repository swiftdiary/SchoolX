//
//  CustomARView.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 15/10/23.
//

import Foundation
import ARKit
import Combine
import SwiftUI
import RealityKit

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                    case .placeBlock(let color):
                        self?.placeBlock(ofColor: color)
                    
                    case .removeAllAnchors:
                        self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func configurationExamples() {
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
    }
    
    func anchorExamples() {
        
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        scene.addAnchor(coordinateAnchor)
    }
    
    func entityExamples() {
        
        let sphere = MeshResource.generateSphere(radius: 1)
        let entity = ModelEntity(mesh: sphere)
        
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    func placeBlock(ofColor color: Color) {
        let block = MeshResource.generateSphere(radius: 0.3)
        let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
}
