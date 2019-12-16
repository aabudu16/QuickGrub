

import ObjectMapper

public class CDYelpCategory: Mappable {

    public var alias: String?
    public var title: String?
    public var parentAliases: [String]?
    public var countryWhitelist: [String]?
    public var countryBlacklist: [String]?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        alias               <- map["alias"]
        title               <- map["title"]
        parentAliases       <- map["parent_aliases"]
        countryWhitelist    <- map["country_whitelist"]
        countryBlacklist    <- map["country_blacklist"]
    }
}
