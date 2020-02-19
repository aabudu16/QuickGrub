import UIKit

 class QuickGrubOnboardOverlay: UIView {
    
     var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    open var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.contentHorizontalAlignment = .center
        button.showsTouchWhenHighlighted = true
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    open var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.contentHorizontalAlignment = .center
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    open var prevLabel: UILabel = {
        let label = UILabel()
        label.text = "Prev"
        label.isHidden = true
        return label
    }()
    
    open var nextLabel: UILabel = {
        let label = UILabel()
        label.text = "Next"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    
    
}
