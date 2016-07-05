//
//  XZNavigationView.m
//  WeiZhiUser
//
//  Created by 李小争 on 16/3/25.
//  Copyright © 2016年 wz. All rights reserved.
//

#import "XZNavigationView.h"

@implementation XZNavigationView

-(IBAction)backButtonClick:(id)sender{
    UIViewController *vc = [self parentViewController];
    // 清除所有子视图
    [vc.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [vc.navigationController popViewControllerAnimated:YES];
}
- (UIViewController *)parentViewController {
    // 如果在视图中需要找到他所在的控制器的话,self.view 需要修改成self
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:NSClassFromString(@"XZShopDetailController")]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
