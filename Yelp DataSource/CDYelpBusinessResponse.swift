

import ObjectMapper

public class CDYelpBusinessResponse: Mappable {

    public var business: CDYelpBusiness?
    public var error: CDYelpError?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        business    <- map[""]
        error       <- map["error"]
    }
}
