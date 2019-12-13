
import ObjectMapper

public class CDYelpError: Mappable {

    public var description: String?
    public var field: String?
    public var code: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        description <- map["description"]
        field       <- map["field"]
        code        <- map["code"]
    }
}
