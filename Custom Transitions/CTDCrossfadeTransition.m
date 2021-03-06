//
//  CTDCrossfadeTransition.m
//  Custom Transitions
//
//  Created by Devon on 12/26/2013.
//  Copyright (c) 2013 Devon. All rights reserved.
//

#import "CTDCrossfadeTransition.h"

@implementation CTDCrossfadeTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];

    UIView *snapshotView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];

    [transitionContext.containerView addSubview:fromVC.view];
    [transitionContext.containerView addSubview:snapshotView];

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    snapshotView.alpha = 0;

    // animate the views’ alpha to perform crossfade
    [UIView animateWithDuration:duration animations:^{
        snapshotView.alpha = 1.0;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1.0;
        [transitionContext.containerView addSubview:toVC.view];
        [snapshotView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
