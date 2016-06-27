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
    
    // 设置导航条标题
    self.title = @"商户详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    OneViewController *oneVc = [OneViewController new];
    oneVc.title = @"one";
    [self addChildViewController:oneVc];
    
    
    TwoViewController *twoVc = [TwoViewController new];
    twoVc.title = @"two";
    [self addChildViewController:twoVc];
    
    ThreeViewController *threeVc = [ThreeViewController new];
    threeVc.title = @"three";
    [self addChildViewController:threeVc];

    [self setIcon:[UIImage imageNamed:@"bgImage.gif"] card:[UIImage imageNamed:@"icon.jpg"] shopName:@"小争测试" withControllers:self.childViewControllers];
    
}

@end
