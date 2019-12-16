

import ObjectMapper

public class CDYelpAutoCompleteResponse: Mappable {

    public var terms: [CDYelpTerm]?
    public var businesses: [CDYelpBusiness]?
    public var categories: [CDYelpCategory]?
    public var error: CDYelpError?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        terms       <- map["terms"]
        businesses  <- map["businesses"]
        categories  <- map["categories"]
        error       <- map["error"]
    }
}
