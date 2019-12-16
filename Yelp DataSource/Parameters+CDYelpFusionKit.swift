

import Alamofire

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {

    static func searchParameters(withTerm term: String?,
                                 location: String?,
                                 latitude: Double?,
                                 longitude: Double?,
                                 radius: Int?,
                                 categories: [CDYelpCategoryAlias]?,
                                 locale: CDYelpLocale?,
                                 limit: Int?,
                                 offset: Int?,
                                 sortBy: CDYelpBusinessSortType?,
                                 priceTiers: [CDYelpPriceTier]?,
                                 openNow: Bool?,
                                 openAt: Int?,
                                 attributes: [CDYelpAttributeFilter]?) -> Parameters {
        var parameters: Parameters = [:]

        if let term = term,
            term != "" {
            parameters["term"] = term
        }
        if let location = location,
            location != "" {
            parameters["location"] = location
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }
        if let radius = radius {
            parameters["radius"] = radius
        }
        if let categories = categories,
            categories.count > 0 {
            parameters["categories"] = categories.map { $0.rawValue }.joined(separator: ",")
        }
        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }
        if let limit = limit {
            parameters["limit"] = limit
        }
        if let offset = offset {
            parameters["offset"] = offset
        }
        if let sortBy = sortBy,
            sortBy.rawValue != "" {
            parameters["sort_by"] = sortBy.rawValue
        }
        if let priceTiers = priceTiers,
            priceTiers.count > 0 {
            parameters["price"] = priceTiers.map { $0.rawValue }.joined(separator: ",")
        }
        if let openNow = openNow {
            parameters["open_now"] = openNow
        }
        if let openAt = openAt {
            parameters["open_at"] = openAt
        }
        if let attributes = attributes,
            attributes.count > 0 {

            var attributesString = ""
            for attribute in attributes {
                attributesString += attribute.rawValue + ","
            }
            let parametersString = String(attributesString[..<attributesString.index(before: attributesString.endIndex)])
            parameters["attributes"] = parametersString
        }

        return parameters
    }

    static func phoneParameters(withPhoneNumber phoneNumber: String!) -> Parameters {
        var parameters: Parameters = [:]

        parameters["phone"] = phoneNumber

        return parameters
    }

    static func transactionsParameters(withLocation location: String?,
                                       latitude: Double?,
                                       longitude: Double?) -> Parameters {
        var parameters: Parameters = [:]

        if let location = location,
            location != "" {
            parameters["location"] = location
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }

        return parameters
    }

    static func businessParameters(withLocale locale: CDYelpLocale?) -> Parameters {
        var parameters: Parameters = [:]

        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }

        return parameters
    }

    static func matchesParameters(withName name: String!,
                                  addressOne: String?,
                                  addressTwo: String?,
                                  addressThree: String?,
                                  city: String!,
                                  state: String!,
                                  country: String!,
                                  latitude: Double?,
                                  longitude: Double?,
                                  phone: String?,
                                  zipCode: String?,
                                  yelpBusinessId: String?,
                                  limit: Int?,
                                  matchThresholdType: CDYelpBusinessMatchThresholdType!) -> Parameters {
        var parameters: Parameters = [:]

        if let name = name,
            name != "" {
            parameters["name"] = name
        }
        if let addressOne = addressOne,
            addressOne != "" {
            parameters["address1"] = addressOne
        }
        if let addressTwo = addressTwo,
            addressTwo != "" {
            parameters["address2"] = addressTwo
        }
        if let addressThree = addressThree,
            addressThree != "" {
            parameters["address3"] = addressThree
        }
        if let city = city,
            city != "" {
            parameters["city"] = city
        }
        if let state = state,
            state != "" {
            parameters["state"] = state
        }
        if let country = country,
            country != "" {
            parameters["country"] = country
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }
        if let phone = phone,
            phone != "" {
            parameters["phone"] = phone
        }
        if let postalCode = zipCode,
            postalCode != "" {
            parameters["postal_code"] = postalCode
        }
        if let yelpBusinessId = yelpBusinessId,
            yelpBusinessId != "" {
            parameters["yelp_business_id"] = yelpBusinessId
        }
        if let limit = limit {
            parameters["limit"] = limit
        }
        parameters["match_threshold"] = matchThresholdType.rawValue

        return parameters
    }

    static func reviewsParameters(withLocale locale: CDYelpLocale?) -> Parameters {
        var parameters: Parameters = [:]

        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }

        return parameters
    }

    static func autocompleteParameters(withText text: String!,
                                       latitude: Double!,
                                       longitude: Double!,
                                       locale: CDYelpLocale?) -> Parameters {
        var parameters: Parameters = [:]

        if let text = text,
            text != "" {
            parameters["text"] = text
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }
        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }

        return parameters
    }

    static func eventParameters(withLocale locale: CDYelpLocale?) -> Parameters {
        var parameters: Parameters = [:]

        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }

        return parameters
    }


    static func featuredEventParameters(withLocale locale: CDYelpLocale?,
                                        location: String?,
                                        latitude: Double?,
                                        longitude: Double?) -> Parameters {
        var parameters: Parameters = [:]

        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }
        if let location = location,
            location != "" {
            parameters["location"] = location
        }
        if let latitude = latitude {
            parameters["latitude"] = latitude
        }
        if let longitude = longitude {
            parameters["longitude"] = longitude
        }

        return parameters
    }

    static func categoriesParameters(withLocale locale: CDYelpLocale?) -> Parameters {
        var parameters: Parameters = [:]

        if let locale = locale,
            locale.rawValue != "" {
            parameters["locale"] = locale.rawValue
        }

        return parameters
    }
}
