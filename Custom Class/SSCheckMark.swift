import UIKit

enum SSCheckMarkStyle : UInt {
    case OpenCircle
    case GrayedOut
}

class SSCheckMark: UIView {

private var checkedBool: Bool = false
// choose whether you like open or grayed out non-selected items
    private var checkMarkStyleReal: SSCheckMarkStyle=SSCheckMarkStyle.OpenCircle

var checked: Bool {
    get {
        return self.checkedBool
    }
    set(checked) {
        self.checkedBool = checked
        self.setNeedsDisplay()
    }
}

var checkMarkStyle: SSCheckMarkStyle {
    get {
        return self.checkMarkStyleReal
    }
    set(checkMarkStyle) {
        self.checkMarkStyleReal = checkMarkStyle
        self.setNeedsDisplay()
    }
}

override func draw(_ rect: CGRect) {
    super.draw(rect)
    if self.checked {
        self.drawRectChecked(rect: rect)
    } else {
        if self.checkMarkStyle == SSCheckMarkStyle.OpenCircle {
            self.drawRectOpenCircle(rect: rect)
        } else if self.checkMarkStyle == SSCheckMarkStyle.GrayedOut {
            self.drawRectGrayedOut(rect: rect)
        }
    }
}

func drawRectChecked(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let checkmarkBlue2 = UIColor.blue
    let shadow2 = UIColor.white

    let shadow2Offset = CGSize(width: 0.0, height: -0.1)
    let shadow2BlurRadius = 2.5
    let frame = self.bounds
    let group = CGRect(x: frame.minX , y: frame.minY , width: frame.width , height: frame.height )

    let checkedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.0 + 0.5), y: group.minY + floor(group.height * 0.0 + 0.9), width: floor(group.width * 1.0 + 0.5) - floor(group.width * 0.0 + 0.5), height: floor(group.height * 1.0 + 0.5) - floor(group.height * 0.0 + 0.5)))

    context!.saveGState()
    context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
    checkmarkBlue2.setFill()
    checkedOvalPath.fill()
    context!.restoreGState()
    UIColor.black.setStroke()
    checkedOvalPath.lineWidth = 1
    checkedOvalPath.stroke()
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height))
    bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height))
    bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
    bezierPath.lineCapStyle = CGLineCap.square
    UIColor.white.setStroke()
    bezierPath.lineWidth = 2
    bezierPath.stroke()
}

func drawRectGrayedOut(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let grayTranslucent = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
    let shadow2 = UIColor.black
    let shadow2Offset = CGSize(width: 0.1, height: -0.1)
    let shadow2BlurRadius = 2.5
    let frame = self.bounds
    let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
    let uncheckedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 0.5), y: group.minY + floor(group.height * 0.00000 + 0.5), width: floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5), height: floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)))

    context!.saveGState()
    context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
    grayTranslucent.setFill()
    uncheckedOvalPath.fill()
    context!.restoreGState()
    UIColor.white.setStroke()
    uncheckedOvalPath.lineWidth = 1
    uncheckedOvalPath.stroke()
    let bezierPath = UIBezierPath()

    bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height))
    bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height))
    bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
    bezierPath.lineCapStyle = CGLineCap.square
    UIColor.white.setStroke()
    bezierPath.lineWidth = 1.3
    bezierPath.stroke()
}

func drawRectOpenCircle(rect: CGRect) {

}
}
