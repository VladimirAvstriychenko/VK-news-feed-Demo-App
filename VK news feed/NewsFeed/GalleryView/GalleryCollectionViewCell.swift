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
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myImageView)
        backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
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
}

