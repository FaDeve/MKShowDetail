//
//  XZCustomViewController.h
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTableView.h"

/**
 *  背景高度
 */
static const CGFloat kHeadViewH = 135;
/**
 *  没有背景高度
 */
static const CGFloat kHeadViewMinH = 64;
/**
 *  标题栏高度
 */
static const CGFloat kTitleBarH = 44;


@interface XZCustomViewController : UIViewController

/**
 *  给继承者使用的: tag:1024
 */
@property (nonatomic, strong) XZTableView *tableView;


@property (nonatomic, weak)   UIView *titleBar;

@property (nonatomic, weak)  NSLayoutConstraint *headHCons;


@property (nonatomic, weak) UILabel *titleLabel;
@property (copy, nonatomic) void(^changeNavigationBar)(CGFloat alpha);
@end
