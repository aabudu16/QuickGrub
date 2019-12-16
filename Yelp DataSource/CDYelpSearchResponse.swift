
import ObjectMapper

public class CDYelpSearchResponse: Mappable {

    public var total: Int?
    public var businesses: [CDYelpBusiness]?
    public var region: CDYelpRegion?
    public var error: CDYelpError?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        total       <- map["total"]
        businesses  <- map["businesses"]
        region      <- map["region"]
        error       <- map["error"]
    }
}
