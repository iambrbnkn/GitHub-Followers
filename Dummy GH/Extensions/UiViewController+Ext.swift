//
//  UiViewController+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 18.01.2024.
//

import UIKit
import SafariServices


extension UIViewController {
    func preseGHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHAlertVC(alertTitle: title, message: message, buttontitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = . crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
