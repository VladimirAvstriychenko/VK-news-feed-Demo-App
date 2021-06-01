//
//  NewsFeedPresenter.swift
//  VK news feed
//
//  Created by Владимир on 29.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {

    case .presentNewsFeed(let feed, let revealedPostIds):
        
        print(revealedPostIds)
        
        let cells = feed.items.map( { cellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds) } )
        
        
        let footerTitle = String.localizedStringWithFormat(NSLocalizedString("news feed cells count", comment: ""), cells.count)
        let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
        
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        
    case .presentUserInfo(user: let user):
        let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
        viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
    case .presentFooterLoader:
        viewController?.displayData(viewModel: .displayFooterLoader)
    }
    
  }
  
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell{
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
       
        let isFullSized = revealedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        //let photoAttachment = self.photoAttachment(feedItem: feedItem)

        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
//        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment, isFullSizedPost: isFullSized)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
//        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
//                                       name: profile.name,
//                                       date: dateTitle,
//                                       text: feedItem.text,
//                                       likes: String(feedItem.likes?.count ?? 0),
//                                       comments: String(feedItem.comments?.count ?? 0),
//                                       shares: String(feedItem.reposts?.count ?? 0),
//                                       views: String(feedItem.views?.count ?? 0),
//                                       //photoAttachment: photoAttachment,
//                                       photoAttachments: photoAttachments,
//                                       sizes: sizes,
//                                       postId: feedItem.postId)
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       //text: feedItem.text,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes,
                                       postId: feedItem.postId)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil}
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3) + "K")
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6) + "M")
        }
        
        
        return counterString
        
        
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGoups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId =  sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGoups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
            
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else {return []}
        
        return attachments.compactMap ({ (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else {return nil}
            
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG,
                                                              width: photo.width,
                                                              height: photo.height)
        })
    }
    
}
