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
@property (nonatomic, assign) CGFloat alpha; ///< 记录导航栏的透明度,返回当前页面的时候回使用
@end

@implementation TestViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeNavigationBarAlpha:self.alpha];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self changeNavigationBarAlpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条标题
    self.title = @"商户详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    OneViewController *oneVc = [OneViewController new];
    oneVc.title = @"one";
    oneVc.changeNavigationBar = ^(CGFloat alpha) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf changeNavigationBarAlpha:alpha];
        strongSelf.alpha = alpha;
    };

    [self addChildViewController:oneVc];
    
    
    TwoViewController *twoVc = [TwoViewController new];
    twoVc.title = @"two";
    [self addChildViewController:twoVc];
    
    ThreeViewController *threeVc = [ThreeViewController new];
    threeVc.title = @"three";
    [self addChildViewController:threeVc];

    [self setIcon:[UIImage imageNamed:@"bgImage.gif"] card:[UIImage imageNamed:@"icon.jpg"] shopName:@"小争测试" withControllers:self.childViewControllers];
    
}

- (void)changeNavigationBarAlpha:(CGFloat)alpha {
    if (alpha >= 0.5) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    // 我在项目中使用的是View代替的导航栏,然后处理,如果直接改navigationBar时应该处理下面
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 这样就更改了全局的导航栏...而且这样使用还有一个问题
    //  如果 A控制器 push B 控制器 如果两个控制器的第一个子视图都是scrollowView 类型的 则会出现导航栏异常,解决办法就是包装一层View
    self.navigationController.navigationBar.alpha = alpha;
}

@end
