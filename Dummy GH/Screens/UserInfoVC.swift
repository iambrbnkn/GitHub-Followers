//
//  UserInfoVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

protocol UserInfiVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: GHDataLoadingVC {
    
    let headerView = UIView()
    let itemViewOnde = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHBodyLabel(textAlingment: .left)
    
    weak var delegate: FollowerListVCDelegate?
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        layoutUI()
        getUserInfo()
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func configVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(wth: user)
                }
            case .failure(let error):
                self.preseGHAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(wth user: User) {
        let repoItemVC = GHRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GHFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOnde)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        let itemViews = [headerView, itemViewOnde, itemViewTwo, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews.forEach { itemView in
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemViewOnde.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOnde.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOnde.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    @objc
    func dissmissVC() {
        dismiss(animated: true)
    }
}


extension UserInfoVC: UserInfiVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            preseGHAlertOnMainThread(title: "Invalid URL", message: "URL attached to this user is invalid", buttonTitle: "Fck!")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            preseGHAlertOnMainThread(title: "No Follower", message: "This user has no followers 😱", buttonTitle: "Gotcha")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dissmissVC()
    }
}
