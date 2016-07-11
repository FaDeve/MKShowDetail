//
//  XZBaseViewController.h
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBaseViewController : UIViewController
/// 头部视图
@property (weak, nonatomic,nullable) IBOutlet UIView *headerView;
@property (weak, nonatomic,nullable) IBOutlet UIImageView *cardView; ///< 背景图片
@property (weak, nonatomic,nullable) IBOutlet UIView *titleBar;  ///< 选择栏
/**
 *  设置显示效果
 *
 *  @param showBtn   titleBar上显示的button
 *  @param vcs       所要创建的控制器
 */
- (void)configTitleBarWithButtonType:(nonnull UIButton *)showBtn showControllers:(nonnull NSArray *)vcs;
@end
