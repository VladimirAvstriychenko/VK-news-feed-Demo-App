//
//  FeedViewController.swift
//  VK news feed
//
//  Created by Владимир on 24.03.2021.
//

import UIKit

class FeedViewController: UIViewController {

    //private let networkService: Networking = NetworkService()
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //networkService.getFeed()
//        let params = ["filters": "post, photo"]
//        networkService.request(path: API.newsFeed, params: params) { (data, error) in
//            if let error = error {
//                print("Error received requesting data: \(error.localizedDescription)")
//            }
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            guard let data = data else {return}
//
//            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
//            //print(response)
////            response?.response.items.map({ (feedItem) in
////                print(feedItem.text)
////            })
//        }
        
        fetcher.getFeed{(feedResponse) in
            guard let feedResponse = feedResponse else {return}
            feedResponse.items.map({print($0.text)})
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
