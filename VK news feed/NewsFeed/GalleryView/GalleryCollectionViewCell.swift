//
//  GalleryColletctionViewCell.swift
//  VK news feed
//
//  Created by Владимир on 16.05.2021.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.6902741194, green: 0.7411854863, blue: 0.7958561182, alpha: 1)
        
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myImageView)
        //backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
        //MARK: myImageViewConstraints
        myImageView.fillSuperview()
        
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowRadius = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
}

