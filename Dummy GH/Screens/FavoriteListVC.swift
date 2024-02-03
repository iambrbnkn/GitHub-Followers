//
//  FavoriteListVC.swift
//  Dummy GH
//
//  Created by Vitaliy on 17.01.2024.
//

import UIKit

class FavoriteListVC: GHDataLoadingVC {
    
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.secondaryText = "You can add favorites on Favorites screen"
            config.text = "No Favorites?!"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureVC() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor =  .systemBackground
    }
    
    func getFavorite() {
        PersistanceManager.retriveFavorites { [weak self ] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                updateUI(with: favorites)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGHAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            }
        }
    }
    
    private func updateUI(with favorites: [Follower]) {
        self.favorites = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
//        if favorites.isEmpty {
//            self.showEmptyStateView(with: "No favorites \n added yet :(", in: self.view)
//        } else {
//            self.favorites = favorites
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                self.view.bringSubviewToFront(self.tableView)
//            }
//        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.favoriteCellID)
    }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.favoriteCellID) as? FavoriteCell else {
            return UITableViewCell()
        }
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistanceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
//                if self.favorites.isEmpty {
//                    self.showEmptyStateView(with: "No favorites \n added yet :(", in: self.view)
//                }
                return
            }
            DispatchQueue.main.async {
                self.presentGHAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}
