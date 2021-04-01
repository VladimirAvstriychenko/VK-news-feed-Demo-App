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
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {

    case .presentNewsFeed(let feed):
        
        let cells = feed.items.map( { cellViewModel(from: $0) } )
        
        let feedViewModel = FeedViewModel.init(cells: cells)
        
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        
        
    }
  }
  
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell{
        return FeedViewModel.Cell.init(iconUrlString: "",
                                       name: "foo name",
                                       date: "foo date",
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))
    }
    
}
