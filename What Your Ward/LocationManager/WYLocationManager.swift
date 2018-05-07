import Foundation
import CoreLocation

let KLocationServiceAuthChangedNotification = "LocationServiceAuthorizationChangedNotification"

class WYLocationManager: NSObject {
    
    static let sharedInstance: WYLocationManager = WYLocationManager()
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10.0
    }
    
    open var isLocationServiceEnabled: Bool {
        let authorisationStatus = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() &&
            authorisationStatus != .denied &&
            authorisationStatus != .notDetermined
    }
    
    open var currentLocation: CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
    
    private func requestAuthorisation() {
        if isLocationServiceEnabled {
            locationManager.startUpdatingLocation()
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func postLocationServiceAuthorizationChangedNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:
            KLocationServiceAuthChangedNotification),
                                        object: currentLocation)
    }
    
    open func startUpdating() {
        if currentLocation == nil {
            requestAuthorisation()
        }
        postLocationServiceAuthorizationChangedNotification()
    }
}

extension WYLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            WYAlertUtility.dismissLocationServicesUnavailableAlert()
            locationManager.startUpdatingLocation()
        case .denied:
            WYAlertUtility.showLocationServicesUnavailableAlert()
        default:
            break
        }
        
        postLocationServiceAuthorizationChangedNotification()
    }
}
