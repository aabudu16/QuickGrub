
import Foundation
import FirebaseFirestore
import FirebaseAuth

struct UserProfile {
    let email: String?
    let uid: String
    let userName: String?
    let dateCreated: Date?
    let photoURL: String?
    let isInformed:Bool?
    
    init(from user: User) {
        self.userName = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
        self.photoURL = user.photoURL?.absoluteString
        self.isInformed = false
    }
    
    init?(from dict: [String: Any], id: String,  isInformed:Bool) {
        guard let userName = dict["userName"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            //MARK: TODO - extend Date to convert from Timestamp?
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
            let isInformed = dict["isInformed"] as? Bool
        
        self.userName = userName
        self.email = email
        self.uid = id
        self.dateCreated = dateCreated
        self.photoURL = photoURL
        self.isInformed = isInformed
    }
    
 
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? " No user name",
            "email": self.email ?? "",
            "photoURL": self.photoURL ?? "",
            "isInformed":self.isInformed ?? false
        ]
    }
}
