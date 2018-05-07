import Foundation

class WWardDetailFetcher {
    class func fetchWardBoundaryGeoJson() -> [String: Any] {
        let path = Bundle.main.path(forResource: "wards-geo-json", ofType: "geojson")!
        let data = FileManager.default.contents(atPath: path)!
        
        var json: [String: Any] = [:]
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            defer {
                if let jsonCasted = jsonObject as? [String: Any] {
                    json = jsonCasted
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return json
    }
    
    class func fetchWardDetails() -> [[String: Any]] {
        let path = Bundle.main.path(forResource: "chennaiwardinfo", ofType: "json")!
        let data = FileManager.default.contents(atPath: path)!
        
        var json: [[String: Any]] = []
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            defer {
                if let jsonCasted = jsonObject as? [[String: Any]] {
                    json = jsonCasted
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return json
    }
}
