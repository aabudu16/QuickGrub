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
        pageControlConstraint()
        continueButtonConstraint()
        skipButtonConstraint()
        prevLabelConstraint()
        nextLabelConstraint()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func pageControlConstraint() {
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10), pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), pageControl.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    private func continueButtonConstraint() {
        self.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20), continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor), continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor), continueButton.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    private func skipButtonConstraint() {
        self.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([skipButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10), skipButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10), skipButton.heightAnchor.constraint(equalToConstant: 20), skipButton.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    private func prevLabelConstraint() {
        pageControl.addSubview(prevLabel)
        prevLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([prevLabel.leadingAnchor.constraint(equalTo: pageControl.leadingAnchor), prevLabel.topAnchor.constraint(equalTo: pageControl.topAnchor), prevLabel.heightAnchor.constraint(equalTo: pageControl.heightAnchor), prevLabel.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    private func nextLabelConstraint() {
        pageControl.addSubview(nextLabel)
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nextLabel.trailingAnchor.constraint(equalTo: pageControl.trailingAnchor), nextLabel.topAnchor.constraint(equalTo: pageControl.topAnchor), nextLabel.heightAnchor.constraint(equalTo: pageControl.heightAnchor), nextLabel.widthAnchor.constraint(equalToConstant: 50)])
    }
}
