//
//  UIView+Layer.h
//  WeiZhiUser
//
//  Created by 微指 on 16/5/24.
//  Copyright © 2016年 WeiZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

//指定大小的圆角处理
- (void)cornerRadius:(CGFloat)radius;

//指定大小圆角，且带border
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

//添加border
- (void)borderWithColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

- (void)circleWithColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

// 对UIView的四个角进行选择性的圆角处理
- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii;

@end
