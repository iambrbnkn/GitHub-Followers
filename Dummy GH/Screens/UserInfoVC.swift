//
//  UserInfoVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GHDataLoadingVC {
    
    let headerView = UIView()
    let itemViewOnde = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHBodyLabel(textAlingment: .left)
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    weak var delegate: UserInfoVCDelegate?
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinViewToEdges(of: view)
        contentView.pinViewToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
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
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(wth: user)
            } catch {
                if let ghError = error as? GHError {
                    presentGHAlert(title: "Something went wrong.", message: ghError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    func configureUIElements(wth user: User) {
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GHRepoItemVC(user: user, delegate: self), to: self.itemViewOnde)
        self.add(childVC: GHFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        let itemViews = [headerView, itemViewOnde, itemViewTwo, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews.forEach { itemView in
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOnde.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOnde.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOnde.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func dissmissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: RepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlert(title: "Invalid URL", message: "URL attached to this user is invalid", buttonTitle: "Fck!")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: FollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGHAlert(title: "No Follower", message: "This user has no followers 😱", buttonTitle: "Gotcha")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dissmissVC()
    }
}


