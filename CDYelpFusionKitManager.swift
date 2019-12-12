
import UIKit

final class CDYelpFusionKitManager: NSObject {

    static let shared = CDYelpFusionKitManager()

    var apiClient: CDYelpAPIClient!

    func configure() {
        // How to authorize using your clientId and clientSecret
        self.apiClient = CDYelpAPIClient(apiKey: Secret.yelpAPIKey)
    }
}
