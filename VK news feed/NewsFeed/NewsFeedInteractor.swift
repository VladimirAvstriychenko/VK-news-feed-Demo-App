//
//  NewsFeedInteractor.swift
//  VK news feed
//
//  Created by Владимир on 29.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
      
    case .getNewsFeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            
            guard let feedResponse = feedResponse else { return }

            //feedResponse.items.map({ print($0.sourceId)})
            //feedResponse.groups.map({print($0.photo)})
            
            self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
        }
    }
  }
}