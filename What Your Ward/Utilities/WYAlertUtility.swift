import UIKit

struct WYAlertUtility {
    public static func showAlert(_ message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: kAppTitle,
                                                                   message: message,
                                                                   preferredStyle: .alert)
        alertController.addAction(self.dismissAction(kOkay, viewController: alertController))
        self.presentAlert(viewController, alertController: alertController)
    }
    
    public static func showMailConfigurationUnavailableAlert() {
        if let viewController = UIApplication.rootViewController {
            let alertController = UIAlertController(title: kAppTitle,
                                                                       message: kMailConfigurationMessage,
                                                                       preferredStyle: .alert)
            alertController.addAction(self.dismissAction(kOkay, viewController: alertController))
            self.presentAlert(viewController, alertController: alertController)
        }
    }
    
    public static func showLocationServicesUnavailableAlert() {
        if let viewController = UIApplication.rootViewController {
            let alertController = UIAlertController(title: kAppTitle,
                                                                       message: kEnableLocationServiceMessage,
                                                                       preferredStyle: .alert)
            alertController.addAction(self.dismissAction(kOkay, viewController: alertController))
            alertController.addAction(self.settingsAction(alertController))
            self.presentAlert(viewController, alertController: alertController)
        }
    }
    
    public static func showMultipleContactsAlert(_ numbers: [String]) {
        if let viewController = UIApplication.rootViewController {
            let alertController = UIAlertController(title: kAppTitle,
                                                                       message: kMultipleContactsMessage,
                                                                       preferredStyle: .actionSheet)
            for number in numbers {
                alertController.addAction(contactsAction(number))
            }
            
            alertController.addAction(dismissAction(kCancel))
            self.presentAlert(viewController, alertController: alertController)
        }
    }
    
    public static func dismissLocationServicesUnavailableAlert() {
        self.dismissGlobalAlertIfAny()
    }
    
    private static func dismissGlobalAlertIfAny() {
        self.dismissAlert(UIApplication.rootViewController)
    }
    
    private static func dismissAction(_ title: String, viewController: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel) { (_) in
            self.dismissAlert(viewController)
        }
    }
    
    private static func dismissAction(_ title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel) { (_) in
            dismissGlobalAlertIfAny()
        }
    }
    
    private static func settingsAction(_ viewController: UIViewController) -> UIAlertAction {
        return UIAlertAction(title: kSettings, style: .default) { (_) in
            WYUtility.openAppSettings()
        }
    }
    
    private static func contactsAction(_ number: String) -> UIAlertAction {
        return UIAlertAction(title: number, style: .default) { (_) in
            WYUtility.dialPhone(number)
            dismissGlobalAlertIfAny()
        }
    }
    
    private static func presentAlert(_ viewController: UIViewController, alertController: UIAlertController) {
        DispatchQueue.main.async { [weak viewController] in
            if let strongViewController = viewController {
                strongViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private static func dismissAlert(_ viewController: UIViewController?) {
        DispatchQueue.main.async { [weak viewController] in
            if let strongViewController = viewController {
                strongViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
