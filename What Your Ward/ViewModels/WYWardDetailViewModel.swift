struct WYWardDetailViewModel {
    private var ward: WYWard!
    
    init(ward: WYWard) {
        self.ward = ward
    }
    
    public var zoneName: String {
        return kZoneNamePrefix + ward.zoneName
    }
    
    public var zoneNumber: String {
        return ward.zoneNo
    }
    
    public var zonalOfficeAddress: String {
        return ward.zonalOfficeAddress.count > 0 ? ward.zonalOfficeAddress : kNoRecordsFound
    }
    
    public var zonalOfficeContactNumber: String {
        return ward.zonalOfficeContactNumber.count > 0 ? ward.zonalOfficeContactNumber.description : kNoRecordsFound
    }
    
    public var zonalOfficeContactNumbers: [String] {
        return ward.zonalOfficeContactNumbers
    }
    
    public var hasMultipleZonalOfficeContactNumbers: Bool {
        return ward.zonalOfficeContactNumbers.count > 1
    }
    
    public var isValidZonalOfficeLandline: Bool {
        return ward.zonalOfficeContactNumber.count > 0
    }
    
    public var wardName: String {
        return kWardNamePrefix + ward.wardName
    }
    
    public var wardNumber: String {
        return ward.wardNo.description
    }
    
    public var wardOfficeAddress: String {
        return ward.wardOfficeAddress.count > 0 ? ward.wardOfficeAddress : kNoRecordsFound
    }
    
    public var wardEmail: String {
        return ward.wardEmail.count > 0 ? ward.wardEmail : kNoRecordsFound
    }
    
    public var isValidWardEmail: Bool {
        return ward.wardEmail.count > 0
    }
    
    public var wardContactNumber: String {
        return ward.wardContactNumber.count > 0 ? ward.wardContactNumber.description : kNoRecordsFound
    }
    
    public var isValidWardContactNumber: Bool {
        return ward.wardContactNumber.count > 0
    }
    
    public var wardContactNumbers: [String] {
        return ward.wardContactNumbers
    }
    
    public var hasMultipleWardContactNumbers: Bool {
        return ward.wardContactNumbers.count > 1
    }
    
    public var wardWhatsAppGroupLink: String {
        return ward.whatsAppGroupLink
    }
}
