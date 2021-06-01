//
//  NewsFeedViewController.swift
//  VK news feed
//
//  Created by Владимир on 29.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {
    
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
    
    @IBOutlet weak var table: UITableView!
    
    private var titleView = TitleView()
    
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
        setupTopBars()
        
        //table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
               
        
        
        //view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    private func setupTable() {
        
        let topInset: CGFloat = 8
        table.contentInset.top = topInset
        
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        table.addSubview(refreshControl)
        table.tableFooterView = footerView
    }
    
    private func setupTopBars(){
        
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        self.view.addSubview(topBar)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            footerView.setTitle(feedViewModel.footerTitle)
            table.reloadData()
            refreshControl.endRefreshing()
            //footerView.setTitle(feedViewModel.cells.count)
            
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
   
        case .displayFooterLoader:
            footerView.showLoader()
            
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height * 0.9 { //90 процентов ленты
            //interactor?.makeRequest(request: .getNewsFeed)
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
    
    //MARK: NewsfeedCodeCellDelegatesi
    
    func revealPost(for cell: NewsFeedCodeCell) {
        //print("test111")
        guard let indexPath = table.indexPath(for: cell) else {return}
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell

        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self 
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
        //return 212
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
        //return 212
    }
    
}
