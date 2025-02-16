import UIKit

final class CityViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Please,Enter city name"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // MARK: - Public Properties
    var onCitySelected: ((CitySuggestion) -> Void)?
    
    // MARK: - Private Properties
    private var suggestions: [CitySuggestion] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
    searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
    searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
    searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
    tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 30),
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func getCities(text: String) {
        NetworkManager2.shared.request (
            target:APIService.getCities(name: text),
            model: DadataResponse.self,
            completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    print(success)
                    suggestions.append(contentsOf: success.suggestions.filter({ $0.data.latitude != nil && $0.data.longitude != nil}))
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
        )
    }
}
    // MARK: - UISearchBarDelegate
    extension CityViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            suggestions = []
            getCities(text: searchText)
        }
    }
    
    //MARK: - UITableViewDataSource
    extension CityViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            suggestions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let data = suggestions[indexPath.row].data
            cell.textLabel?.text = data.city ?? data.region
            return cell
        }
        
    }
    
    // MARK: - UITableViewDelegate
    extension CityViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            onCitySelected?(suggestions[indexPath.row])
            navigationController?.popViewController(animated: true)
        }
    }

