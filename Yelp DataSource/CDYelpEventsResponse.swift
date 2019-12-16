

import ObjectMapper

public class CDYelpEventsResponse: Mappable {

    public var total: Int?
    public var events: [CDYelpEvent]?
    public var error: CDYelpError?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        total   <- map["total"]
        events  <- map["events"]
        error   <- map["error"]
    }
}
