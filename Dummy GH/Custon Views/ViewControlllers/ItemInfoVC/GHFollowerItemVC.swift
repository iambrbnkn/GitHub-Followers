//
//  GHFollowerItemVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import Foundation

protocol FollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GHFollowerItemVC: GHItemInfoVC {
    weak var delegate : FollowerItemVCDelegate?
        
    init(user: User, delegate: FollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
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
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}
