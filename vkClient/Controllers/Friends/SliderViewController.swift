import UIKit

class SliderViewController: UIViewController {
    
    var selectedIndex: Int = 1
    var images = [UIImage]()
    
    var animator: UIViewPropertyAnimator!
    
    lazy var nextImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    @IBOutlet weak var sliderImageView: UIImageView!
    
    enum Direction {
        case left, right
        
        init(x: CGFloat) {
            self = x > 0 ? .right : .left
        }
    }
    
    override func viewDidLoad() {
        for i in 1...7 {
            images.append((UIImage(named: "user\(i)") ?? UIImage(systemName: "note"))!)
        }
        sliderImageView.image = images[0]
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(pan)
    }
    
    @objc func onPan(recognizer: UIPanGestureRecognizer) {
        guard let panView = recognizer.view else { return }
        let translation = recognizer.translation(in: panView)
        let direction = Direction(x: translation.x)
        
        switch recognizer.state {
            case .began:
                animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: {
                    self.sliderImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    self.sliderImageView.alpha = 0
                })
                if canSlide(direction) {
                    if direction == .left {
                        nextImage.image = UIImage(named: "user\(selectedIndex+1)")
                    } else {
                        nextImage.image = UIImage(named: "user\(selectedIndex-1)")
                    }
                    view.addSubview(nextImage)
                    let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
                    nextImage.frame = view.bounds.offsetBy(dx: offsetX, dy: 0)
                }
                animator.addAnimations({
                    self.nextImage.center = self.view.center
                    self.nextImage.alpha = 1
                }, delayFactor: 0.2)
                animator.addCompletion { (position) in
                    guard position == .end else { return }
                    self.selectedIndex = direction == .left ? self.selectedIndex + 1 : self.selectedIndex - 1
                    self.sliderImageView.alpha = 1
                    self.sliderImageView.transform = .identity
                    self.sliderImageView.image = self.images[self.selectedIndex - 1]
                    self.nextImage.removeFromSuperview()
                }
                animator.pauseAnimation()
            case .changed:
                animator.fractionComplete = abs(translation.x) / panView.frame.width
            case .ended:
                if canSlide(direction), animator.fractionComplete > 0.6 {
                    animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                } else {
                    animator.stopAnimation(true)
                    UIView.animate(withDuration: 0.2) {
                        self.sliderImageView.transform = .identity
                        self.sliderImageView.alpha = 1
                        let offsetX = direction == .left ? self.view.bounds.width : -self.view.bounds.width
                        self.nextImage.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                        self.nextImage.transform = .identity
                    }
                }
            default:
                break
        }
    }
    
    private func canSlide (_ direction: Direction) -> Bool {
        if direction == .left {
            return selectedIndex < images.count
        } else {
            return selectedIndex > 1
        }
    }
}
