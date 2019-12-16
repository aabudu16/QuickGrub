

import ObjectMapper

public class CDYelpBusiness: Mappable {

    public var id: String?
    public var name: String?
    public var imageUrl: URL?
    public var isClosed: Bool?
    public var url: URL?
    public var price: String?
    public var phone: String?
    public var displayPhone: String?
    public var photos: [String]?
    public var hours: [CDYelpHour]?
    public var rating: Double?
    public var reviewCount: Int?
    public var categories: [CDYelpCategory]?
    public var distance: Double?
    public var coordinates: CDYelpCoordinates?
    public var location: CDYelpLocation?
    public var transactions: [String]?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        imageUrl        <- (map["image_url"], URLTransform())
        isClosed        <- map["is_closed"]
        url             <- (map["url"], URLTransform())
        price           <- map["price"]
        phone           <- map["phone"]
        displayPhone    <- map["display_phone"]
        photos          <- map["photos"]
        hours           <- map["hours"]
        rating          <- map["rating"]
        reviewCount     <- map["review_count"]
        categories      <- map["categories"]
        distance        <- map["distance"]
        coordinates     <- map["coordinates"]
        location        <- map["location"]
        transactions    <- map["transactions"]
    }
}
