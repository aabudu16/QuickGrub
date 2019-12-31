//
//  CustomerReviewTableViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/31/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Alamofire

enum CDYelpRouter: URLRequestConvertible {

    case search(parameters: Parameters)
    case phone(parameters: Parameters)
    case transactions(type: String, parameters: Parameters)
    case business(id: String, parameters: Parameters)
    case matches(parameters: Parameters)
    case reviews(id: String, parameters: Parameters)
    case autocomplete(parameters: Parameters)
    case event(id: String, parameters: Parameters)
    case events(parameters: Parameters)
    case featuredEvent(parameters: Parameters)
    case allCategories(parameters: Parameters)
    case categoryDetails(alias: String, parameters: Parameters)

    var method: HTTPMethod {
        switch self {
        case .search(parameters: _),
             .phone(parameters: _),
             .transactions(type: _, parameters: _),
             .business(id: _, parameters: _),
             .matches(parameters: _),
             .reviews(id: _, parameters: _),
             .autocomplete(parameters: _),
             .event(id: _, parameters: _),
             .events(parameters: _),
             .featuredEvent(parameters: _),
             .allCategories(parameters: _),
             .categoryDetails(alias: _, parameters: _):
            return .get
        }
    }

    var path: String {
        switch self {
        case .search(parameters: _):
            return "businesses/search"
        case .phone(parameters: _):
            return "businesses/search/phone"
        case .transactions(let type, parameters: _):
            return "transactions/\(type)/search"
        case .business(let id, parameters: _):
            return "businesses/\(id)"
        case .matches(parameters: _):
            return "businesses/matches"
        case .reviews(let id, parameters: _):
            return "businesses/\(id)/reviews"
        case .autocomplete(parameters: _):
            return "autocomplete"
        case .event(let id, parameters: _):
            return "events/\(id)"
        case .events(parameters: _):
            return "events"
        case .featuredEvent(parameters: _):
            return "events/featured"
        case .allCategories(parameters: _):
            return "categories"
        case .categoryDetails(let alias, parameters: _):
            return "categories/\(alias)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try CDYelpURL.base.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .search(let parameters),
             .phone(let parameters),
             .transactions(type: _, let parameters),
             .business(id: _, let parameters),
             .matches(let parameters),
             .reviews(id: _, let parameters),
             .autocomplete(let parameters),
             .event(id: _, let parameters),
             .events(let parameters),
             .featuredEvent(let parameters),
             .allCategories(let parameters),
             .categoryDetails(alias: _, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
