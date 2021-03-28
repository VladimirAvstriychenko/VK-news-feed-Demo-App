//
//  AuthViewController.swift
//  VK news feed
//
//  Created by Владимир on 23.03.2021.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthentificationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //authService = AppDelegate.shared().authService
//        let mySceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
//        if mySceneDelegate != nil {
//            authService = mySceneDelegate?.authService
//        }
        
        let scene = UIApplication.shared.connectedScenes.first
        if let mySceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            authService = mySceneDelegate.authService
        }
    }
    
    @IBAction func signInTouched(_ sender: UIButton) {
        authService.wakeUpSession()
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
