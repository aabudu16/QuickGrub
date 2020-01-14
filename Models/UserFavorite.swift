//
//  UserFavorite.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct UserFavorite {
    let creatorID: String
    let dateCreated: Date?
    let id :String
    let venueID:String
    let name:String
    
    
    init(creatorID: String, dateCreated: Date? = nil, venueID:String, name:String) {
        self.creatorID = creatorID
        self.dateCreated = dateCreated
         self.id = UUID().description
        self.venueID = venueID
        self.name = name
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userID = dict["creatorID"] as? String,
            let venueID = dict["venueID"] as? String,
            let name = dict["name"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.creatorID = userID
        self.dateCreated = dateCreated
        self.id = id
        self.name = name
        self.venueID = venueID
    }
    
    var fieldsDict: [String: Any] {
        return [
            "creatorID": self.creatorID,
            "dateCreated": self.dateCreated,
            "name": self.name,
            "venueID": self.venueID
        ]
    }
}
