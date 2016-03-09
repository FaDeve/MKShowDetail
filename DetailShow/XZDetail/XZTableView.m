//
//  XZTableView.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "XZTableView.h"

@implementation XZTableView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    
    
    for (UIView *tabBarChildView in _tabBar.subviews) {
        
        CGPoint childP = [self convertPoint:curP toView:tabBarChildView];
        
        if ([tabBarChildView pointInside:childP withEvent:event]) {
            // 点击了按钮
            
            // 通知个人控制器切换内容视图
            [[NSNotificationCenter defaultCenter] postNotificationName:XZClickBtnNote object:nil userInfo:@{XZClickBtnObjcKey: tabBarChildView}];
            
            // 处理完事件，结束当前事件处理
            return;
            
        }
    }
    
    // 如果没有处理事件，就调用系统自带的处理方式
    [super touchesBegan:touches withEvent:event];
    
    
}

@end
