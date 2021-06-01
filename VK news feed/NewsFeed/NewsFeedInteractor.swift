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
  
//    private var revealedPostIds = [Int]()
//    private var feedResponse: FeedResponse?
//
//    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService(), authService: nil)

    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        //    switch request {
        //
        //    case .getNewsFeed:
        //        fetcher.getFeed { [weak self] (feedResponse) in
        //
        //            //guard let feedResponse = feedResponse else { return }
        //
        //            //feedResponse.items.map({ print($0.sourceId)})
        //            //feedResponse.groups.map({print($0.photo)})
        //
        //            //self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
        //
        //            self?.feedResponse = feedResponse
        //            self?.presentFeed()
        //        }
        //    case .revealPostIds(postId: let postId):
        //        revealedPostIds.append(postId)
        //        presentFeed()
        //        print("111")
        //    case .getUser:
        //        fetcher.getUser { (userResponse) in
        //            //print(userResponse)
        //            self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
        //        }
        //    }
        
        switch request {
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (revealedPostIds, feed ) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
        case .revealPostIds(postId: let postId):
            service?.revealPostIds(forPostId: postId, completion: { (revealedPostIds, feed) in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { (revealedPostIds, feed) in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        }
       
    }
    
    //    private func presentFeed() {
    //        guard let feedResponse = self.feedResponse else {return}
    //        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
    //    }
}
