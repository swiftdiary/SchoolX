//
//  ImageCacher.swift
//  SchoolX
//
//  Created by Muhammadjon Madaminov on 14/10/23.
//

import Foundation
import SwiftUI
import AVKit
import Combine


class ImageCacher: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellable = Set<AnyCancellable>()
    let urlString: String
    let cacheManagerPhoto = CacheManager.instance
    let imageKey: String
    
    init(url: String, key: String) {
        imageKey = key
        urlString = url
        getImage()
    }
    
    func getImage() {
        if let savedImage = cacheManagerPhoto.getImage(key: imageKey) {
            print("Getting image from cache")
            image = savedImage
        } else {
            print("downloading")
            downloadImage()
        }
    }
    
    //in here i used caching for images and i used file manager for videos(but only if they fully downloaded from internet)
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { (data, response) in
//                return UIImage(data: data)
//            }
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: {[weak self] (returnedImage) in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                self.isLoading = false
                self.image = returnedImage
                self.cacheManagerPhoto.addPhoto(key: self.imageKey, image: image)
            }
            .store(in: &cancellable)

    }
}
