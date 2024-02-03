//
//  GHRepoItemVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

protocol RepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GHRepoItemVC: GHItemInfoVC {
    
    weak var delegate : RepoItemVCDelegate?
        
    init(user: User, delegate: RepoItemVCDelegate) {
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
        iteminfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        iteminfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person.fill")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
