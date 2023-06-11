//
//  Courses.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 11/06/23.
//

import UIKit

class UsersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    var product: UserResponse? {
        didSet {
            self.updateUI()
        }
    }

    func updateUI() {
        productImageView.loadFrom(URLAddress: product?.avatar_url)
        loginLabel.text = product?.login
    }
}
