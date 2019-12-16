

import ObjectMapper

public class CDYelpReview: Mappable {

    public var id: String?
    public var text: String?
    public var url: URL?
    public var rating: Int?
    public var timeCreated: String?
    public var user: CDYelpUser?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        id          <- map["id"]
        text        <- map["text"]
        url         <- (map["url"], URLTransform())
        rating      <- map["rating"]
        timeCreated <- map["time_created"]
        user        <- map["user"]
    }
}
