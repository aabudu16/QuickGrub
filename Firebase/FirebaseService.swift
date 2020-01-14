

import Foundation
import FirebaseFirestore

enum FireStoreCollections: String {
    case users
    case favorite
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}

class FirestoreService {
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: UserProfile, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, email:String? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        
        if let email = email {
            updateFields["email"] = email
        }
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    func updateCurrentUserIsInformedField(isInformed:Bool? = true, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            return
        }
        var updateFields = [String:Any]()
        if let isInformed = isInformed{
                   updateFields["isInformed"] = isInformed
               }
               db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
                   if let error = error {
                       completion(.failure(error))
                   } else {
                       completion(.success(()))
                   }
                   
               }
    }
    
    func getAllUsers(completion: @escaping (Result<[UserProfile], Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> UserProfile? in
                    let userID = snapshot.documentID
                    let user = UserProfile(from: snapshot.data(), id: userID)
                    return user
                })
                completion(.success(users ?? []))
            }
        }
    }
    
    func getUser(userID:String, completion:@escaping (Result<UserProfile, Error>) -> ()){
        db.collection(FireStoreCollections.users.rawValue).document(userID).getDocument { (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else {
                let userdata = snapshot?.data()
                let user = UserProfile(from: userdata!, id: userID)
                completion(.success(user!))
            }
        }
    }
    
    //MARK: Posts
    func createFavorite(favorite: UserFavorite, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = favorite.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.favorite.rawValue).addDocument(data: fields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
     func getAllFavorites(sortingCriteria: SortingCriteria? = nil, completion: @escaping (Result<[UserFavorite], Error>) -> ()) {
            let completionHandler: FIRQuerySnapshotBlock = {(snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let favorites = snapshot?.documents.compactMap({ (snapshot) -> UserFavorite? in
                        let favoriteID = snapshot.documentID
                        let favorite = UserFavorite(from: snapshot.data(), id: favoriteID)
                        return favorite
                    })
                    completion(.success(favorites ?? []))
                }
            }
            
            //type: Collection Reference
            let collection = db.collection(FireStoreCollections.favorite.rawValue)
            //If i want to sort, or even to filter my collection, it's going to work with an instance of a different type - FIRQuery
            //collection + sort/filter settings.getDocuments
            if let sortingCriteria = sortingCriteria {
                let query = collection.order(by:sortingCriteria.rawValue, descending: sortingCriteria.shouldSortDescending)
                query.getDocuments(completion: completionHandler)
            } else {
                collection.getDocuments(completion: completionHandler)
            }
        }


    func getFavorites(forUserID: String, completion: @escaping (Result<[UserFavorite], Error>) -> ()) {
        db.collection(FireStoreCollections.favorite.rawValue).whereField("creatorID", isEqualTo: forUserID).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let favorite = snapshot?.documents.compactMap({ (snapshot) -> UserFavorite? in
                    let fovoriteID = snapshot.documentID
                    let favorite = UserFavorite(from: snapshot.data(), id: fovoriteID)
                    return favorite
                })
                completion(.success(favorite ?? []))
            }
        }
        
    }
    
    private init () {}
}
