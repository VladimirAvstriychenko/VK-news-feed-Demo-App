//
//  NetworkService.swift
//  VK news feed
//
//  Created by Владимир on 28.03.2021.
//

import Foundation
import UIKit

protocol Networking {
    
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
    
}

final class NetworkService: Networking {
  
    
    private var authService: AuthentificationService?
    
    init() {
        let scene = UIApplication.shared.connectedScenes.first
        if let mySceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            self.authService = mySceneDelegate.authService
        }
        //self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService?.token else {return}
        
        let params = ["filters" : "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.v
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request:URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map( { URLQueryItem(name:$0, value: $1) } )
        
        
        return components.url!
      
    }
    
    
    
}
