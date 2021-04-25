//
//  NewsFeedLayoutCalculator.swift
//  VK news feed
//
//  Created by Владимир on 04.04.2021.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}



protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
    
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: PostLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFront)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: AttachmentFrame
        
        //maxY - это самая нижняя точка текста поста
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            
            //print("Height \(attachment.height), width \(attachment.width)")
            
            // выясняем соотношение, только надо делить не инты
            let photoHeight = Float(attachment.height)
            let photoWidth = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            
            //print("Ratio: \(ratio)")
            
            
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: BottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
       
        //MARK: TotalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
}

