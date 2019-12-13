
import ObjectMapper

public class CDYelpEvent: Mappable {

    public var attendingCount: Int?
    public var category: String?
    public var cost: Int?
    public var costMax: Int?
    public var description: String?
    public var eventSiteUrl: URL?
    public var id: String?
    public var imageUrl: URL?
    public var interestedCount: Int?
    public var isCanceled: Bool?
    public var isFree: Bool?
    public var isOfficial: Bool?
    public var latitude: Double?
    public var longitude: Double?
    public var name: String?
    public var ticketsUrl: URL?
    public var timeEnd: Date?
    public var timeStart: Date?
    public var location: CDYelpLocation?
    public var businessId: String?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        attendingCount  <- map["attending_count"]
        category        <- map["category"]
        cost            <- map["cost"]
        costMax         <- map["cost_max"]
        description     <- map["description"]
        eventSiteUrl    <- (map["event_site_url"], URLTransform())
        id              <- map["id"]
        imageUrl        <- (map["image_url"], URLTransform())
        interestedCount <- map["interested_count"]
        isCanceled      <- map["is_canceled"]
        isFree          <- map["is_free"]
        isOfficial      <- map["is_official"]
        latitude        <- map["latitude"]
        longitude       <- map["longitude"]
        name            <- map["name"]
        ticketsUrl      <- (map["tickets_url"], URLTransform())
        timeEnd         <- (map["time_end"], DateTransform())
        timeStart       <- (map["time_start"], DateTransform())
        location        <- map["location"]
        businessId      <- map["business_id"]
    }
}
