import UIKit

open class QuickGrubOnBoardingPage: UIView {
     //MARK: -- objects
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Page Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Page Sub Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewConstraint()
        titleConstraint()
        subViewConstraint()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
     //MARK: -- private func
    private func imageViewConstraint() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30), imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30), imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30), imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)])
    }
    
    private func titleConstraint() {
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10), title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30), title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30), title.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func subViewConstraint() {
        self.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5), subTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30), subTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30), subTitle.heightAnchor.constraint(equalToConstant: 100)])
    }
}
