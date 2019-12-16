

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    public typealias CDColor = UIColor
#elseif os(macOS)
    import Cocoa
    public typealias CDColor = NSColor
#endif
