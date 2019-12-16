

import ObjectMapper

public class CDYelpReviewsResponse: Mappable {

    public var total: Int?
    public var possibleLanguages: [String]?
    public var reviews: [CDYelpReview]?
    public var error: CDYelpError?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        total               <- map["total"]
        possibleLanguages   <- map["possible_languages"]
        reviews             <- map["reviews"]
        error               <- map["error"]
    }
}
