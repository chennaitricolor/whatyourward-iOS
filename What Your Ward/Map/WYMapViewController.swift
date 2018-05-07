import UIKit
import CoreLocation
import MapKit

class WYMapViewController: UIViewController {
    
    private var polygons: [WYPolygon] = []
    private var locationMarker: WYMarkerAnnotation!
    
    private let kLocationMarkerResueIdentifier = "LocationMarkerReuseIdentifier"
    
    private let defaultRadiusInMetres: CLLocationDistance = 5000
    private let kPolygonStrokeWidth: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupMapView() {
        mapView?.delegate = self
        mapView?.showsCompass = true
        mapView?.isRotateEnabled = true
        
        configureLocationMarker()
        configurePanGestureRecognizer()
        NotificationCenter.default.addObserver(self, selector: #selector(centerUserLocation),
                                               name: NSNotification.Name(rawValue:
                                                KLocationServiceAuthChangedNotification), object: nil)
    }
    
    private func configurePanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        panGesture.delegate = self
        mapView?.addGestureRecognizer(panGesture)
    }
    
    @objc private func panned() {
        if let centerCoordinate = mapView?.centerCoordinate {
            locationMarker.coordinate = centerCoordinate
        }
    }
    
    private func configureLocationMarker() {
        locationMarker = WYMarkerAnnotation.init(coordinate: defaultCoordinate)
        mapView?.addAnnotation(locationMarker)
    }
    
    private var mapView: MKMapView? {
        return self.view as? MKMapView
    }
    
    @objc private func centerUserLocation() {
        self.mapView?.region = userRegion
    }
    
    private var userRegion: MKCoordinateRegion {
        var region = defaultRegion
        if let userLocation = WYLocationManager.sharedInstance.currentLocation {
            region = mapRegion(from: userLocation)
        }
        
        return region
    }
    
    private func mapRegion(from location: CLLocationCoordinate2D) -> MKCoordinateRegion {
        let radius = CLLocationDistance(defaultRadiusInMetres)
        
        return MKCoordinateRegionMakeWithDistance(location, radius, radius)
    }
    
    open func drawPolygons(_ polygons: [WYPolygon]) {
        if self.polygons.count > 0 {
            mapView?.removeOverlays(polygons)
        }
        
        self.polygons = polygons
        mapView?.addOverlays(polygons)
    }
    
    open var centerCoordinate: CLLocationCoordinate2D? {
        return mapView?.centerCoordinate
    }
}

extension WYMapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith
        otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension WYMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        locationMarker.coordinate = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.fillColor = WYColorUtility.randomColor
            renderer.strokeColor = WYColorUtility.polygonStrokeColor
            renderer.lineWidth = kPolygonStrokeWidth
            
            return renderer
        }
        
        return MKPolygonRenderer() //For other types of overlays
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var locationMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier: kLocationMarkerResueIdentifier)
        if locationMarkerView == nil {
            locationMarkerView = WYAnnotationView(annotation: annotation,
                                                  reuseIdentifier: kLocationMarkerResueIdentifier)
            locationMarkerView?.image = #imageLiteral(resourceName: "LocationPin")
        }
        
        return locationMarkerView
    }
}

extension WYMapViewController {
    
    func envelopingPolygon(_ coordinate: CLLocationCoordinate2D) -> MKPolygon? {
        var polygon: MKPolygon?
        let filteredPolygons = polygons.filter {$0.contains(coor: coordinate)}
        if let filteredPolygon = filteredPolygons.first {
            polygon = filteredPolygon
        }
        
        return polygon
    }
    
    private var defaultRegion: MKCoordinateRegion {
        return chennaiRegion
    }
    
    private var defaultCoordinate: CLLocationCoordinate2D {
        return chennaiCoordinate
    }
    
    private var chennaiRegion: MKCoordinateRegion {
        return mapRegion(from: chennaiCoordinate)
    }
    
    private var chennaiCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(12.9838112, 80.2437003)
    }
}
