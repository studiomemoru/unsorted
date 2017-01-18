// Helper function to embed/remove view controller as a child view controller. (Swift)
//

import UIKit

func EmbedChildViewController(child: UIViewController, parent: UIViewController, containerView: UIView) {
    parent.addChildViewController(child)
    child.view.frame = containerView.bounds
    containerView.addSubview(child.view)
    child.didMoveToParentViewController(parent)
}

func RemoveChildViewController(child: UIViewController) {
    child.willMoveToParentViewController(nil)
    child.view.removeFromSuperview()
    child.removeFromParentViewController()
}
