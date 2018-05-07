import Foundation
import UIKit
import MessageUI

struct WYEmailUtility {
    static func email(_ emailIds: [String], presentingViewController: UIViewController) {
        if !MFMailComposeViewController.canSendMail() {
            WYAlertUtility.showMailConfigurationUnavailableAlert()
            return
        }
        let emailViewController: MFMailComposeViewController = MFMailComposeViewController()
        emailViewController.setToRecipients(emailIds)
        
        if let viewController = presentingViewController as? MFMailComposeViewControllerDelegate {
            emailViewController.mailComposeDelegate = viewController
        }
        
        DispatchQueue.main.async { [weak presentingViewController] in
            if let strongPresentingViewController = presentingViewController {
                strongPresentingViewController.present(emailViewController, animated: true, completion: nil)
            }
        }
    }
    
    static func forwardToMailApp(_ emailId: String) {
        if emailId.count <= 0 && emailId != kNoRecordsFound {
            return //TODO:: Add Regex for Phone number
        }
        
        //Works only on device and not on Simulator
        if let url = URL(string: "mailto:\(emailId)") {
            UIApplication.shared.open(url)
        }
    }
}
