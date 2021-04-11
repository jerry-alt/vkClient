import UIKit

@IBDesignable
open class RoundedAvatar: UIView {
    var imageName: String?
    
    @IBInspectable
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    lazy var imageView: UIImageView = {
        var imView = UIImageView()
        imView.image = image
        return imView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    private func setup() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        //layer.shadowRadius = 2
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.layer.bounds.width * 0.5
        imageView.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        self.imageView.isUserInteractionEnabled = true
//        self.imageView.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        
        self.addSubview(imageView)
    }
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveEaseOut) {
            self.transform = .identity
        } completion: { _ in return }
        
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    
    @IBInspectable var circle: Bool {
        get {
            return layer.cornerRadius == self.bounds.width*0.5
        }
        set {
            if newValue == true {
                self.cornerRadius = self.bounds.width*0.5
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
