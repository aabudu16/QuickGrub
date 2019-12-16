

import ObjectMapper

public class CDYelpLocation: Mappable {

    public var addressOne: String?
    public var addressTwo: String?
    public var addressThree: String?
    public var city: String?
    public var state: String?
    public var zipCode: String?
    public var country: String?
    public var displayAddress: [String]?
    public var crossStreets: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        addressOne      <- map["address1"]
        addressTwo      <- map["address2"]
        addressThree    <- map["address3"]
        city            <- map["city"]
        state           <- map["state"]
        zipCode         <- map["zip_code"]
        country         <- map["country"]
        displayAddress  <- map["display_address"]
        crossStreets    <- map["cross_streets"]
    }
}
