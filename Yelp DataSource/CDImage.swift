

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    public typealias CDImage = UIImage
#elseif os(macOS)
    import Cocoa
    public typealias CDImage = NSImage
#endif
