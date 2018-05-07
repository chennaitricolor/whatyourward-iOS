import CoreLocation

struct WYWardViewModel {
    
    var wards: [WYWard] = []
    private var wardDetails: [[String: Any]] = []
    
    init() {
        wardDetails = WWardDetailFetcher.fetchWardDetails()
        
        let wardBoundaryGeoJson = WWardDetailFetcher.fetchWardBoundaryGeoJson()
        wards = loadWards(wardBoundaryGeoJson)
    }
    
    private func loadWards(_ wardBoundaryGeoJson: [String: Any]) -> [WYWard] {
        var wards: [WYWard] = []
        if let wardInformations = wardBoundaryGeoJson[kFeatures] as? [[String: Any]] {
            for wardInformation in wardInformations {
                var ward = WYWard()
                
                if let properties = wardInformation[kProperties] as? [String: Any],
                    let wardNumberString = properties[kName] as? String {
                    ward.updateWardNumber(wardNumberString)
                }
                
                if ward.isValidWard {
                    if let geometry = wardInformation[kGeometry] as? [String: Any] {
                        ward.loadWardGeographicalProperties(geometry)
                    }
                    let wardIndex = ward.wardNo - 1
                    let wardDetailsJson = wardDetails[wardIndex]
                    ward.loadWardDetails(wardDetailsJson)
                    
                    wards.append(ward)
                }
            }
        }
        
        return wards
    }
    
    public func fetchWardDetail(wardNumber: Int) -> WYWard? {
        let result: [WYWard] = wards.filter({$0.wardNo == wardNumber && wardNumber > 0})
        return result.first
    }
}
