import MapKit
class WYPolygon: MKPolygon {
    var wardIdentifier = kInvalid
    
    class func polygon(from polygonCoordinates: [CLLocationCoordinate2D]) -> WYPolygon {
        let polygon: WYPolygon = WYPolygon(coordinates: polygonCoordinates, count: polygonCoordinates.count)
        
        return polygon
    }
}

extension WYPolygon {
    func contains(coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPointForCoordinate(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path.contains(polygonViewPoint)
    }
}
