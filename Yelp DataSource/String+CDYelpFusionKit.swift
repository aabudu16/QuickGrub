

extension String {

    static func searchLinkPath(withTerm term: String?,
                               category: CDYelpCategoryAlias?,
                               location: String?) -> String {
        var path = "search"

        if term != nil || category != nil || location != nil {
            path += "?"
        }

        if let term = term?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            path += "terms=\(term)"
        }

        if term != nil,
            let category = category?.rawValue {
            path += "&category=\(category)"
        } else if let category = category {
            path += "category=\(category)"
        }

        if term != nil,
            let location = location?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            path += "&location=\(location)"
        } else if category != nil,
            let location = location {
            path += "&location=\(location)"
        } else if let location = location {
            path += "location=\(location)"
        }

        return path
    }

    static func businessLinkPath(forId id: String!) -> String {
        var path = "biz/"

        if let id = id {
            path += "\(id)"
        }

        return path
    }
}
