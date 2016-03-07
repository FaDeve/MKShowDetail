//
//  TestViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "TestViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardImage = [UIImage imageNamed:@"bgImage.gif"];
    self.iconImage = [UIImage imageNamed:@"icon.jpg"];
    
    // 设置导航条标题
    self.title = @"商户详情";
    OneViewController *oneVc = [OneViewController new];
    oneVc.title = @"one";
    [self addChildViewController:oneVc];
    
    
    TwoViewController *twoVc = [TwoViewController new];
    twoVc.title = @"two";
    [self addChildViewController:twoVc];
    
    ThreeViewController *threeVc = [ThreeViewController new];
    threeVc.title = @"three";
    [self addChildViewController:threeVc];

}

@end
