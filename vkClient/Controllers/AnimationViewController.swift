import UIKit

class AnimationViewController: UINavigationController, UINavigationControllerDelegate {
    var interactiveTransition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
            case .push:
                interactiveTransition.viewController = toVC
                return Animator()
            case .pop:
                if navigationController.viewControllers.first != toVC {
                    interactiveTransition.viewController = toVC
                }
                return Animator()
            default:
                return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted: Bool = false
    var shouldFinished: Bool = false
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePanGestureRecognizer))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func handleScreenEdgePanGestureRecognizer (_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch  recognizer.state {
            case .began:
                hasStarted = true
                viewController?.navigationController?.popViewController(animated: true)
            case .changed:
                let translation = recognizer.translation(in: recognizer.view)
                let relativeTranslation = translation.x / (recognizer.view?.frame.width ?? 1)
                let progress = max(0, min(1, relativeTranslation))
                shouldFinished = progress > 0.33
                update(progress)
            case .ended:
                hasStarted = false
                shouldFinished ? finish() : cancel()
            case .cancelled:
                hasStarted = false
                cancel()
            default:
                return
        }
    }
}


class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
                
        transitionContext.containerView.addSubview(destination.view)
        destination.view.transform = CGAffineTransform(rotationAngle: 90)
      //  destination.view.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            destination.view.alpha = 1
            destination.view.transform = .identity
        } completion: { (finished) in
            transitionContext.completeTransition(finished)
        }
        
    }
    
}
