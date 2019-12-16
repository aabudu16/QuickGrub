

import ObjectMapper

public class CDYelpUser: Mappable {

    public var id: String?
    public var profileUrl: URL?
    public var name: String?
    public var imageUrl: URL?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        id          <- map["id"]
        profileUrl  <- (map["profile_url"], URLTransform())
        name        <- map["name"]
        imageUrl    <- (map["image_url"], URLTransform())
    }
}
