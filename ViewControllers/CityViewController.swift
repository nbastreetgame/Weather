//
//  CityViewController.swift
//  WeatherStore
//
//  Created by Андрей Попов on 21.01.2025.
//

import UIKit

class CityViewController: UIViewController {
    // MARK: - UI Elements
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search  city"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage() // Убираем фон
        return searchBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    private func setupUI() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16)
            ])
        }
    }

