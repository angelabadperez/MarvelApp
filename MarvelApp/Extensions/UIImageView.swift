//
//  UIImageView.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 29/12/20.
//

import UIKit

// MARK: - Cache for images

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension

extension UIImageView {

    func loadImage(image: Character.Image, size: Character.Image.Sizes, using dataManager: DataManager) {
        // Create image URL based on path, size and extension
        let urlString = "\(image.path)/\(size.rawValue).\(image.imageExtension)"
        guard let url = URL(string: urlString) else {
            fatalError("Unable to create image URL")
        }
        
        self.image = nil
        
        // Check if there is an image in the cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            // If true, set the image to the current UIImageView and return
            self.image = imageFromCache as? UIImage
            return
        }
        
        // If false, download the image
        dataManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                imageCache.setObject(image, forKey: urlString as AnyObject)
                self.image = image
            case .failure(_):
                self.image = UIImage(named: "no_image")
            }
        }
    }
}
