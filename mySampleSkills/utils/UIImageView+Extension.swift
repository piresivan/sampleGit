//
//  UIImageView+Extension.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 11/06/23.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String?) {
        guard let url = URL(string: URLAddress ?? "") else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
