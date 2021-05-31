//
//  NetworkDataFetcher.swift
//  VK news feed
//
//  Created by Владимир on 29.03.2021.
//

import UIKit

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    private let authService: AuthentificationService
    
    let networking: Networking
    
//    let scene = UIApplication.shared.connectedScenes.first
//    if let mySceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
//        authService = mySceneDelegate.authService
//    }
    init(networking: Networking, authService: AuthentificationService?) {
        self.networking = networking
        var authService1: AuthentificationService?
        if authService == nil {
            let scene = UIApplication.shared.connectedScenes.first
            if let mySceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                //self.authService = mySceneDelegate.authService
                authService1 = mySceneDelegate.authService
            }
        } else {
            //self.authService = authService!
            authService1 = authService
        }
        self.authService = authService1!
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else {return}
        let params = ["user_ids" : userId, "fields": "photo_100, verified"]
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let txt = String(decoding: data!, as: UTF8.self)
            print(txt)
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void){
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}
