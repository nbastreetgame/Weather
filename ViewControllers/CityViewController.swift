//
//  CityViewController.swift
//  WeatherStore
//
//  Created by Андрей Попов on 21.01.2025.
//

import UIKit


class CityViewController: UIViewController,UISearchBarDelegate {
  
    
 // MARK: - UI Elements
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "City Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let tableVw: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tv
    }()
    
    private var cities = [String]()
    private var filteredCities = [String]()
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        setupUI()
        
        
    }
    private func setupUI() {
        
        tableVw.dataSource = self
        
        view.addSubview(searchBar)
        view.addSubview(tableVw )
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            tableVw.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 30),
            tableVw.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableVw.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func getCities(text: String) {
        NetworkManager2.shared.request (
            target:APIService.getCities(name: text),
            model: DadataResponse.self,
            completion: { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        )
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getCities(text: searchText)
        
    }
    
}
//MARK: - UITableViewDataSource
extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVw.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .systemBlue
        case 1:
            cell.backgroundColor = .systemGray
        case 2:
            cell.backgroundColor = .systemGreen
        default:
            break
        }
        return cell
    }
     
}
