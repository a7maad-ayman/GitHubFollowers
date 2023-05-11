//
//  UIViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Ahmad Ayman Mansour on 08/05/2023.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String , message:String , buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
