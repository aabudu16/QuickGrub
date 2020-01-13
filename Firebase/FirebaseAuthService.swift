import Foundation
import FirebaseAuth


class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func updateUserEmail(email: String? = nil, completion: @escaping (Result<(),Error>) -> ()){
        let updateEmail = auth.currentUser
        
        if let email = email{
            updateEmail?.updateEmail(to: email, completion: { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        }
        
    }
    
    func updateUserFields(userName: String? = nil,photoURL: URL? = nil, completion: @escaping (Result<(),Error>) -> ()){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changeRequest?.displayName = userName
        }
        if let photoURL = photoURL {
            changeRequest?.photoURL = photoURL
        }
        
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    
    func resetPassword(email:String, completion: @escaping (Result<(), Error>) -> ()){
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func logoutUser(completion: @escaping (Result<(), Error>) -> ()){
        do{
            try auth.signOut()
            completion(.success(()))
        }catch let error{
            completion(.failure(error))
        }
    }
    private init () {}
    
    
}
