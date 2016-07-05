//
//  XZNavigationView.h
//  WeiZhiUser
//
//  Created by 李小争 on 16/3/25.
//  Copyright © 2016年 wz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZNavigationView : UIView
@property (nonatomic, weak) IBOutlet UIImageView  *bgImageView;
@property (nonatomic, weak) IBOutlet UIButton  *backButton;
@property (nonatomic, weak) IBOutlet UILabel  *titleLabel;

@property (nonatomic, weak) IBOutlet UIButton  *firstButton;

@property (nonatomic, weak) IBOutlet UIButton  *secondButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelRightConstraint;
@end
