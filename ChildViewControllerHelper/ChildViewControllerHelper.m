/*
   Helper function to embed/remove view controller as a child view controller. (Objective-C)

 */


#import <UIKit/UIKit.h>

void EmbedChildViewController(UIViewController *child, UIViewController *parent, UIView *containerView)
{
    [parent addChildViewController:child];
    child.view.frame = containerView.bounds;
    [containerView addSubview:child.view];
    [child didMoveToParentViewController:parent];
}

void RemoveChildViewController(UIViewController *child)
{
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}
