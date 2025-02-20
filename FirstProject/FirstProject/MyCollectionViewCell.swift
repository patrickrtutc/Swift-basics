//
//  MyCollectionViewCell.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/18/25.
//

import UIKit

// Custom implementation of a UICollectionViewCell
class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    
    static let reuseIdentifier = "MyCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: .main)
    }

}
