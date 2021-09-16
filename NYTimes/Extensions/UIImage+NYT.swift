//
//  UIImage+NYT.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import UIKit
import Foundation

enum ImageDownloadError: Error {
    case invalidUrl
}

extension UIImageView {
    
    func setImage(_ url: URL) {
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, resp, err) in
            
            guard err == nil else {
                return
            }
            
            if let data = data, (200..<206).contains(((resp as? HTTPURLResponse)?.statusCode ?? 500)),
               let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.animate(img)
                }
            }
            
        }.resume()

    }
    
    func setImage(_ string: String) throws {
        
        guard let url = URL(string: string) else {
            throw ImageDownloadError.invalidUrl
        }
        
        setImage(url)
    }
    
    
    func animate(_ image: UIImage) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            self.image = image
        } completion: { (_) in
            
        }

    }
}
