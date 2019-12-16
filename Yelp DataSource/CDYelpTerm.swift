

import ObjectMapper

public class CDYelpTerm: Mappable {

    public var text: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        text    <- map["text"]
    }
}
