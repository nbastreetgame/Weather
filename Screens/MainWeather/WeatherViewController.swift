import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var temperatureLabel: UILabel = {
        let label = CustomLabel(fontSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = CustomLabel(fontSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = CustomLabel(fontSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonCityController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getLocation()
        
    }
   // MARK: - Private methods
    @objc func buttonCityController() {
        let CityViewController = CityViewController()
        CityViewController.onCitySelected = { [weak self] suggestion in
            guard let self,
                  let lat = suggestion.data.latitude,
                  let lon = suggestion.data.longitude,
                  let doubleLat = Double(lat),
                  let doubleLon = Double(lon) else { return }
            self.fetchWeather(lat: doubleLat, lon: doubleLon)
        }
        navigationController?.pushViewController(CityViewController, animated: true)
    }

    private func setupBackground() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        if currentHour >= 7 && currentHour < 15 {
            // Утро: 7:00 - 14:59
            setBackgroundState(state: .morning)
        } else if currentHour >= 15 && currentHour < 19 {
            // Вечер: 15:00 - 18:59
            setBackgroundState(state: .evening)
        } else {
            // Ночь: 19:00 - 6:59
            setBackgroundState(state: .night)
        }
    }
      
      private enum BackgroundState {
          case evening
          case night
          case morning
      }
      
      private func setBackgroundState( state: BackgroundState) {
          switch state {
          case .evening:
        //      backgroundImageView.backgroundColor = UIColor(named: "eveningWeather")
              backgroundImageView.image = UIImage(named: "morningWeather")
          case .night:
       //       backgroundImageView.backgroundColor = UIColor(named: "nightWeather")
              backgroundImageView.image = UIImage(named: "eveningWeather")
          case .morning:
              backgroundImageView.image = UIImage(named: "nightWeather") ?? UIImage()
              
          }
      }
    
    private func setupUI() {
          view.backgroundColor = .systemBackground
        
        view.addSubview(backgroundImageView)
        
          view.addSubview(temperatureLabel)
          view.addSubview(cityLabel)
          view.addSubview(conditionLabel)
          view.addSubview(searchButton)
          setupBackground()
        

        NSLayoutConstraint.activate ([
    backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
    backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
    temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    temperatureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
    cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            
    conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    conditionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            
    searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    searchButton.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 150),
    searchButton.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor,constant: 18),
    searchButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor,constant: -18),
        ])
    }
    
    private func getLocation() {
        LocationManager.shared.getCurrentLocation { [weak self] location in
          guard let self = self else { return }
            print(String(describing: location))
            self.fetchWeather(lat:Double(location.coordinate.latitude), lon: Double(location.coordinate.longitude))
        }
    }
    func fetchWeather(lat: Double, lon: Double) {
        NetworkManager2.shared.request(target: APIService.getWeather(lat: lat, lon: lon), model: WeatherModel.self, completion: { result in
            print("+++++\(result)")
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.updateWeatherUI(with: success)
                }
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    private func updateWeatherUI(with weatherModel: WeatherModel) {
        //  обновляем UILabel с данными о погоде
        guard let temp = weatherModel.list?.first?.main?.temp else { return }
        let temperatureCelsius = temp - 273.15
        let weatherCondition = weatherModel.list?.first?.weather?.first?.main ?? "Неизвестно"
        temperatureLabel.text = "\(Int(temperatureCelsius))°C"
        cityLabel.text = weatherModel.city?.name
        conditionLabel.text = weatherCondition
    }
    
}




