//
//  GHFollowerItemVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import Foundation

class GHFollowerItemVC: GHItemInfoVC {
    var user: User!
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        iteminfoViewOne.set(itemInfoType: .followers, with: user.followers)
        iteminfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
