

import ObjectMapper

public class CDYelpCategoryResponse: Mappable {

    public var category: CDYelpCategory?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        category    <- map["category"]
    }
}
