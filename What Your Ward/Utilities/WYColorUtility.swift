import UIKit

struct WYColorUtility {
    static var randomColor: UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.1)
    }
    
    static var polygonStrokeColor: UIColor {
        return UIColor(white: 0.0, alpha: 0.2)
    }
}
