
import ObjectMapper

public class CDYelpOpen: Mappable {

    public var isOvernight: Bool?
    public var end: String?
    public var day: Int?
    public var start: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        isOvernight <- map["is_overnight"]
        end         <- map["end"]
        day         <- map["day"]
        start       <- map["start"]
    }
}
