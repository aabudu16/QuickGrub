

import ObjectMapper

public class CDYelpCategoriesResponse: Mappable {

    public var categories: [CDYelpCategory]?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        categories  <- map["categories"]
    }
}
