import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manger = CLLocationManager()
    static let shared = LocationManager()
    private var locationFetchCompletion: ((CLLocation) -> Void)?
    
    private var location: CLLocation? {
        didSet {
            guard let  location else {
                return }
            locationFetchCompletion?(location)
        }
    }
    
    public func getCurrentLocation(completion: @escaping(CLLocation) -> Void) {
        locationFetchCompletion = completion
        manger.requestWhenInUseAuthorization()
        manger.delegate = self
        manger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error to request location\n\(error)")
        }
}
 
