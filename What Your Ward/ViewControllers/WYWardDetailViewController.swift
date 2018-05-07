import UIKit
import SafariServices
import MessageUI

class WYWardDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet private weak var zoneName: UILabel!
    @IBOutlet private weak var zonalOfficeAddress: UILabel!
    @IBOutlet private weak var zonalContact: UILabel!
    @IBOutlet private weak var zoneNumber: UILabel!
    @IBOutlet private weak var wardName: UILabel!
    @IBOutlet private weak var wardOfficeAddress: UILabel!
    @IBOutlet private weak var wardContact: UILabel!
    @IBOutlet private weak var wardEmail: UILabel!
    @IBOutlet private weak var wardNumber: UILabel!
    @IBOutlet private weak var joinButton: UIButton!
    @IBOutlet private weak var joinIcon: UIImageView!
    @IBOutlet private weak var joinButtonContainer: UIView!
    @IBOutlet private weak var zoneContactButton: UIButton!
    @IBOutlet private weak var wardContactButton: UIButton!
    @IBOutlet private weak var wardEmailButton: UIButton!
    
    private var ward: WYWard!
    private var viewModel: WYWardDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        configureUI()
        configureGestures()
        displayWardDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureUI() {
        joinButtonContainer.layer.cornerRadius = 10.0
        joinButtonContainer.layer.masksToBounds = true
    }
    
    private func configureGestures() {
        let joinIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(joinButtonPressed))
        joinIcon.addGestureRecognizer(joinIconTapGesture)
        
        let zonePhoneTapGesture = UITapGestureRecognizer(target: self, action: #selector(callZoneOffice))
        zonalContact.addGestureRecognizer(zonePhoneTapGesture)
        
        let wardPhoneGesture = UITapGestureRecognizer(target: self, action: #selector(callWardOffice))
        wardContact.addGestureRecognizer(wardPhoneGesture)
        
        let wardEmailGesture = UITapGestureRecognizer(target: self, action: #selector(mailWardOffice))
        wardEmail.addGestureRecognizer(wardEmailGesture)
    }
    
    public func setWard(_ ward: WYWard) {
        self.ward = ward
        viewModel = WYWardDetailViewModel(ward: ward)
    }
    
    private func displayWardDetails() {
        zoneName.text = viewModel.zoneName
        zonalOfficeAddress.text = viewModel.zonalOfficeAddress
        zoneNumber.text = viewModel.zoneNumber
        
        zonalContact.text = viewModel.zonalOfficeContactNumber
        zoneContactButton.isEnabled = viewModel.isValidZonalOfficeLandline
        
        wardName.text = viewModel.wardName
        wardOfficeAddress.text = viewModel.wardOfficeAddress
        
        wardContact.text = viewModel.wardContactNumber
        wardContactButton.isEnabled = viewModel.isValidWardContactNumber
        
        wardEmail.text = viewModel.wardEmail
        wardEmail.isEnabled = viewModel.isValidWardEmail
        
        wardNumber.text = viewModel.wardNumber
    }
    
    @IBAction private func callZoneOffice() {
        if viewModel.hasMultipleZonalOfficeContactNumbers {
            WYUtility.dialMultipleContacts(viewModel.zonalOfficeContactNumbers)
            return
        }
        WYUtility.dialPhone(viewModel.zonalOfficeContactNumber)
    }
    
    @IBAction private func callWardOffice() {
        if viewModel.hasMultipleWardContactNumbers {
            WYUtility.dialMultipleContacts(viewModel.wardContactNumbers)
            return
        }
        
        WYUtility.dialPhone(viewModel.wardContactNumber)
    }
    
    @IBAction private func mailWardOffice() {
        WYEmailUtility.email([viewModel.wardEmail], presentingViewController: self)
    }
    
    @IBAction private func joinButtonPressed() {
        if let whatsAppGroupUrl = URL(string: viewModel.wardWhatsAppGroupLink) {
            let safariViewController = SFSafariViewController(url: whatsAppGroupUrl)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - <MFMailComposeViewControllerDelegate> methods
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
