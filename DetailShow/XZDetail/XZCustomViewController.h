//
//  XZCustomViewController.h
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTableView.h"

@interface XZCustomViewController : UIViewController
/**
 *  给继承者使用的
 */
@property (nonatomic, strong) XZTableView *tableView;


@property (nonatomic, weak)   UIView *titleBar;

@property (nonatomic, weak)  NSLayoutConstraint *headHCons;


@property (nonatomic, weak) UILabel *titleLabel;
@end
