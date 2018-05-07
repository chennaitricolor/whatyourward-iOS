import UIKit
import MapKit

class WYAnnotationView: MKAnnotationView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = #imageLiteral(resourceName: "LocationPin")
    }
}
