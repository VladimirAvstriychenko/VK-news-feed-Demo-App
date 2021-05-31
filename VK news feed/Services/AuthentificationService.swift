//
//  AuthentificationService.swift
//  VK news feed
//
//  Created by Владимир on 23.03.2021.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthentificationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    
    private let appId = "7799185"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId : String? {
        return VKSdk.accessToken()?.userId
    }
        
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        print("inited!")
    }
    
    func wakeUpSession(){
        let scope = ["offline",
                     "photos",
                     "wall",
                     "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("Authorized!")
                delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("Initialized!")
                VKSdk.authorize(scope)
            } else {
                print("auth problem, state: \(state), error: \(String(describing: error?.localizedDescription))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    // MARK: VkSdkDelegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VkSdkUIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
