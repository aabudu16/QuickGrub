
import UIKit

final class CDYelpFusionKitManager: NSObject {

    static let shared = CDYelpFusionKitManager()

    var apiClient: CDYelpAPIClient!

    func configure() {
        // How to authorize using your clientId and clientSecret
        self.apiClient = CDYelpAPIClient(apiKey: "izCFqEx0usiPwAiv_ymJ4Sl2Lr_mpnN6U_VeEkn1iUyEUWLM2Rd76A6NlswCI-HlYVWYT2WYRFtNnD04lgageyBKPJkqDDA75C8UsJYwc7oXWMGDFSCRU93zoTBaW3Yx")
    }
}
