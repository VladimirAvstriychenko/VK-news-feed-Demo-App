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
    
    case .some:
        print(".some Presenter")
    case .presentNewsFeed:
        print(".peresentNewsFeed Presenter")
        viewController?.displayData(viewModel: .displayNewsFeed)
    }
  }
  
}
