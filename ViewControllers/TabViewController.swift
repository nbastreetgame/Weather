import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab1 = WeatherViewController()
        tab1.title = "Weather"
        let tab2 = CityViewController()
        tab2.title = "City"
        let tab3 = WeatherConditionsViewController()
        tab3.title = "Conditions"
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        let nav3 = UINavigationController(rootViewController: tab3)
        
        nav1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "City", image: UIImage(systemName: "location.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Conditions", image: UIImage(systemName: "cloud.moon.bolt.fill"), tag: 3)
        
        
        setViewControllers([
            nav1,nav2,nav3
        ], animated: true)
    }
    

 
}
