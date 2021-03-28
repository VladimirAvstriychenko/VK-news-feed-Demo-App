//
//  UIViewController+Storyboard.swift
//  VK news feed
//
//  Created by Владимир on 25.03.2021.
//

import UIKit

extension UIViewController{
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewContorller = storyboard.instantiateViewController(withIdentifier: name) as? T {
            return viewContorller
        } else {
            fatalError("No initial view controller in \(name)")
        }
    }
}
