import CoreLocation

struct WYWard {
    var coordinates: [CLLocationCoordinate2D] = []
    var zoneNo: String = ""
    var zoneName: String = ""
    var zonalOfficeAddress: String = ""
    var zonalOfficeContactNumber: String = ""
    var zonalOfficeContactNumbers: [String] = []
    var zonalOfficerEmail: String = ""
    var zonalOfficerMobie: Int = kInvalid
    var wardNo: Int = kInvalid
    var wardName: String = ""
    var wardOfficeAddress = ""
    var whatsAppGroupLink: String = ""
    var wardContactNumber: String = ""
    var wardContactNumbers: [String] = []
    var wardEmail: String = ""
    
    public var isValidWard: Bool {
        return wardNo > 0
    }
    
    // MARK: - Setters
    public mutating func updateWardNumber(_ wardNumberString: String) {
        let replacementSting = "Ward "
        let numberString = wardNumberString.replacingOccurrences(of: replacementSting, with: "")
        if let number = Int(numberString) {
            wardNo = number
        }
    }
    
    public mutating func loadWardGeographicalProperties(_ geometry: [String: Any]) {
        if let type = geometry[kType] as? String, type == kPolygon {
            if let polygons = geometry[kCoordinates] as? [[[Double]]] {
                for polygon in polygons {
                    for coordinate in polygon {
                        let longitude = CLLocationDegrees(coordinate[0])
                        let lattitude = CLLocationDegrees(coordinate[1])
                        let coordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
                        addCoordinate(coordinate2D)
                    }
                }
            }
        }
    }
    
    private mutating func loadZoneDetails(_ zoneDetails: [String: Any]) {
        
        if let zoneNo = zoneDetails[kZoneNo] as? String {
            self.zoneNo = zoneNo
        }
        
        if let zoneName = zoneDetails[kZoneName] as? String {
            self.zoneName = zoneName
        }
        
        if let zonalOfficeAddress = zoneDetails[kZonalOfficeAddress] as? String {
            self.zonalOfficeAddress = zonalOfficeAddress
        }
        
        if let zonalOfficeContactNumber = zoneDetails[kZonalOfficePhone] as? Int {
            self.zonalOfficeContactNumber = zonalOfficeContactNumber.description
            zonalOfficeContactNumbers = [zonalOfficeContactNumber.description]
        } else if let zonalOfficeContactNumber = zoneDetails[kZonalOfficePhone] as? String {
            self.zonalOfficeContactNumber = zonalOfficeContactNumber
            self.zonalOfficeContactNumbers = zonalOfficeContactNumber.components(separatedBy: "/")
        }
        
        if let zonalOfficerMobile = zoneDetails[kZonalOfficerMobile] as? Int {
            self.zonalOfficerMobie = zonalOfficerMobile
        }
    }
    
    public mutating func loadWardDetails(_ wardDetails: [String: Any]) {
        if let wardName = wardDetails[kWardName] as? String {
            self.wardName = wardName
        }
        
        if let wardOfficeAddress = wardDetails[kWardOfficeAddress] as? String {
            self.wardOfficeAddress = wardOfficeAddress
        }
        
        if let whatsAppGroupLink = wardDetails[kWhatsAppGroupLink] as? String {
            self.whatsAppGroupLink = whatsAppGroupLink
        }
        
        if let wardEmail = wardDetails[kWardOfficeEmail] as? String {
            self.wardEmail = wardEmail
        }
        
        if let wardContact = wardDetails[kWardOfficePhone] as? Int {
            wardContactNumber = wardContact.description
            wardContactNumbers = [wardContact.description]
        } else if let wardContact = wardDetails[kWardOfficePhone] as? String {
            wardContactNumber = wardContact
            wardContactNumbers = wardContact.components(separatedBy: "/")
        }
        
        if let zoneInfo = wardDetails[kZoneInfo] as? [String: Any] {
            loadZoneDetails(zoneInfo)
        }
    }
    
    private mutating func addCoordinate(_ coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
    }
}
