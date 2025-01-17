import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        view.backgroundColor = .systemBackground
    }
    
    private func getLocation() {
        LocationManager.shared.getCurrentLocation { location in
            print(String(describing: location ))
            NetworkManager.shared.request(target: APIService.getWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude), model: WeatherModel.self, completion: { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            })
            }
        }
    }



