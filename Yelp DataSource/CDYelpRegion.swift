

import ObjectMapper

public class CDYelpRegion: Mappable {

    public var center: CDYelpCenter?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        center  <- map["center"]
    }
}
