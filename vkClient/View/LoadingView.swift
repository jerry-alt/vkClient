import UIKit

class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    func setup() {
        // отрисовываем индикатор загрузки
        self.backgroundColor = .white
        self.isHidden = false
        let circleSize: CGFloat = 12
        let circle1 = createCircle(size: circleSize, x: -20, y: 0, color: .blueberry)
        let circle2 = createCircle(size: circleSize, x: 0, y: 0, color: .maroon)
        let circle3 = createCircle(size: circleSize, x: 20, y: 0, color: .asparagus)
        let rect = CAShapeLayer()
        rect.backgroundColor = UIColor.white.cgColor
        
        self.layer.addSublayer(rect)
        self.addSubview(circle1)
        self.addSubview(circle2)
        self.addSubview(circle3)
        
        circle1.layer.opacity = 0.2
        
        // анимируем
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                circle3.layer.opacity = 1
                circle1.layer.opacity = 0.2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                circle1.layer.opacity = 1
                circle2.layer.opacity = 0.2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.2) {
                circle2.layer.opacity = 1
                circle3.layer.opacity = 0.2
            }
        } completion: { _ in return }
        
        // прячем через 2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
    
    // отрисовываем кружки
    func createCircle(size: CGFloat, x: CGFloat, y: CGFloat, color: UIColor) -> UIView {
        let circle = UIView()
        circle.frame = CGRect(x: self.center.x + x, y: self.center.y + y, width: size, height: size)
        circle.layer.backgroundColor = color.cgColor
        circle.layer.cornerRadius = size / 2
        return circle
    }
}
