//
//  GHItemInfoVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

class GHItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let iteminfoViewOne = GHItemInfoView()
    let iteminfoViewTwo = GHItemInfoView()
    let actionButton = GHButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureBackGroundView()
        configureStackView()
    }
    
    private func configureBackGroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(iteminfoViewOne)
        stackView.addArrangedSubview(iteminfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubviews(stackView, actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
