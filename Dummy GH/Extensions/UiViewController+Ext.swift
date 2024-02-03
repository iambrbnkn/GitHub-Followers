//
//  UiViewController+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 18.01.2024.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGHAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GHAlertVC(alertTitle: title, message: message, buttontitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = . crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GHAlertVC(
            alertTitle: "Something went wrong",
            message: "We were unable to complete your task.",
            buttontitle: "Ok"
        )
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = . crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
