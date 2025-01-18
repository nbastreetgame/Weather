import UIKit

// MARK: - WeatherViewController

class WeatherViewController: UIViewController {
    
    
    // MARK: - UI Elements
    
    private let temperatureLabel = CustomLabel(fontSize: 48)
    private let cityLabel = CustomLabel(fontSize: 24)
    private let conditionLabel = CustomLabel(fontSize: 36)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setupBackground()
        setupUI()
        getLocation()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Изменение цвета в зависимости от времени суток
    
    func setupBackground() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        
        let backgroundImage: UIImage
        
        if currentHour >= 7 && currentHour < 15 {
            // Утро: 7:00 - 14:59
            backgroundImage = UIImage(named: "morning_background")!
        } else if currentHour >= 15 && currentHour < 19 {
            // Вечер: 15:00 - 18:59
            backgroundImage = UIImage(named: "evening_background")!
        } else {
            // Ночь: 19:00 - 6:59
            backgroundImage = UIImage(named: "night_background")!
        }
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Устанавливаем ограничения для изображения фона
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.sendSubviewToBack(backgroundImageView)
    }
    
    
    // MARK: - Lifecycle Methods
    
    func setupUI() {
        // Добавляем метки на экран
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        view.addSubview(conditionLabel)
        
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    // MARK: - Location Methods
    
    private func getLocation() {
        LocationManager.shared.getCurrentLocation { location in
            print(String(describing: location ))
            NetworkManager.shared.request(target: APIService.getWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude), model: WeatherModel.self, completion: { result in
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
    }
    
    private func updateWeatherUI(with weatherModel: WeatherModel) {
        // Пример: обновляем UILabel с данными о погоде
        guard let temp = weatherModel.list.first?.main.temp else { return }
        let temperatureCelsius = temp - 273.15
        let weatherCondition = weatherModel.list.first?.weather.first?.main.rawValue ?? "Неизвестно"
        temperatureLabel.text = "\(Int(temperatureCelsius))°C"
        cityLabel.text = weatherModel.city.name
        conditionLabel.text = weatherCondition
    }
}





