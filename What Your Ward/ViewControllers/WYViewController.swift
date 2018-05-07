import UIKit
import MapKit

class WYViewController: UIViewController {
    
    private var viewModel: WYWardViewModel = WYWardViewModel()
    
    private var mapViewController: WYMapViewController?
    
    private let homeToMapEmbedSegueIdentifier = "HomeToMapEmbedSegueIdentifier"
    private let homeToWardDetailSegueIdentifier = "HomeToWardDetailSegueIdentifier"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        preparePolygons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case homeToMapEmbedSegueIdentifier:
                mapViewController = segue.destination as? WYMapViewController
            case homeToWardDetailSegueIdentifier:
                if let ward: WYWard = sender as? WYWard,
                    let viewController: WYWardDetailViewController = segue.destination as? WYWardDetailViewController {
                    viewController.setWard(ward)
                }
            default:
                break
            }
        }
    }

    func preparePolygons() {
        var polygons: [WYPolygon] = []
        for ward in viewModel.wards {
            let polygon: WYPolygon = WYPolygon.polygon(from: ward.coordinates)
            polygon.wardIdentifier = ward.wardNo
            polygons.append(polygon)
        }
        
        mapViewController?.drawPolygons(polygons)
    }
    
    @IBAction private func nextButtonPressed() {
        openRespectiveWard()
    }
    
    private func openRespectiveWard() {
        if let ward = viewModel.fetchWardDetail(wardNumber: currentlySelectedWardNumber) {
            DispatchQueue.main.async { [weak self] in
                if let strongSelf = self {
                    strongSelf.performSegue(withIdentifier: strongSelf.homeToWardDetailSegueIdentifier, sender: ward)
                }
            }
            
            return
        }
        
        showMissingWardAlert()
    }
    
    private func showMissingWardAlert() {
        WYAlertUtility.showAlert(kInvalidWardMessage, viewController: self)
    }
    
    // MARK: Getters
    var currentlySelectedWardNumber: Int {
        var wardNumber = kInvalid
        if let centerCoordinate = mapViewController?.centerCoordinate {
            let polygon = mapViewController?.envelopingPolygon(centerCoordinate)
            if let customPolygon = polygon as? WYPolygon {
                wardNumber = customPolygon.wardIdentifier
            }
        }
        
        return wardNumber
    }
}
