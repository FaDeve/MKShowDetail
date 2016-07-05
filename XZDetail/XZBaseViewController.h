//
//  XZBaseViewController.h
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBaseViewController : UIViewController

/**
 *  设置显示效果
 *
 *  @param iconImage 头像
 *  @param cardImage 背景图片
 *  @param name      标题
 *  @param vcs       所要创建的控制器
 */
- (void)setIcon:(UIImage *)iconImage card:(UIImage *)cardImage shopName:(NSString *)name withControllers:(NSArray *)vcs;
@end
