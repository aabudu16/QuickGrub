

import Foundation
import UIKit

enum priceData:String{
    case oneDollar = "$"
    case twoDollars = "$$"
    case threeDollars = "$$$"
    case fourDollars = "$$$$"
}
//MARK: Enum Cell Identifier
enum Identifiers:String{
    case categoryCell
}

//MARK: Enum navigationBar button switch
enum Mode{
    case view
    case select
}

enum CurrentState{
    case selected
    case deselected
}


enum Const {
    static let closeCellHeight: CGFloat = 179
    static let openCellHeight: CGFloat = 488
    static let rowsCount = 50
}
