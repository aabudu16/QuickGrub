

import ObjectMapper

public class CDYelpCoordinates: Mappable {

    public var latitude: Double?
    public var longitude: Double?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }
}
