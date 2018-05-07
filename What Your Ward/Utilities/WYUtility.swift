import UIKit

struct WYUtility {
    static func dialPhone(_ number: String) {
        let phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        if phoneNumber.count <= 0 {
            return
        }
        
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    static func dialMultipleContacts(_ numbers: [String]) {
        var vindicatedContacts = [String]()
        for number in numbers {
            let vindicatedNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
            if vindicatedNumber.count > 0 {
                vindicatedContacts.append(vindicatedNumber)
            }
        }
        
        if vindicatedContacts.count <= 0 {
            return
        }
        
        WYAlertUtility.showMultipleContactsAlert(vindicatedContacts)
    }
    
    static func openSettings() {
        if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString),
            UIApplication.shared.canOpenURL(settingsUrl) {
            DispatchQueue.main.async {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    static func openAppSettings() {
        if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString),
            UIApplication.shared.canOpenURL(settingsUrl) {
            DispatchQueue.main.async {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    static var canOpenWhatsApp: Bool {
        if let url = URL(string: kWhatsAppUrl) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

extension UIApplication {
    class var rootViewController: UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
}
