
import UIKit

public extension CDImage {

    private class func cdImage(named name: String!) -> CDImage? {
#if os(iOS) || os(tvOS)
        return CDImage(named: name,
                       in: Bundle(identifier: CDYelpFusionKitBundleIdentifier),
                       compatibleWith: nil)
#elseif os(watchOS)
        return CDImage(named: name)
#else
#if swift(>=4.2)
        let bundle = Bundle(identifier: CDYelpFusionKitBundleIdentifier)
        return bundle?.image(forResource: name)
#elseif swift(>=4.0)
        let bundle = Bundle(identifier: CDYelpFusionKitBundleIdentifier)
        let resource = CDImage.Name(rawValue: name)
        return bundle?.image(forResource: resource)
#else
        let bundle = Bundle(identifier: CDYelpFusionKitBundleIdentifier)
        return bundle?.image(forResource: name)
#endif
#endif
    }

    class func yelpBurstLogoRed() -> CDImage? {
        return CDImage.cdImage(named: "yelp_burst_logo_red")
    }

    class func yelpBurstLogoWhite() -> CDImage? {
        return CDImage.cdImage(named: "stars_5")
    }

    class func yelpLogo() -> CDImage? {
        return CDImage.cdImage(named: "stars_5")
    }

    class func yelpLogoOutline() -> CDImage? {
        return CDImage.cdImage(named: "stars_5")
    }

    class func yelpStars(numberOfStars: CDYelpStars!,
                         forSize size: CDYelpStarsSize!) -> CDImage? {
        return CDImage.cdImage(named: "yelp_stars_\(numberOfStars.rawValue)_\(size.rawValue)")
    }
}
