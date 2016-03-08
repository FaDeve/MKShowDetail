//
//  XZCustomViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "XZCustomViewController.h"

#import "UIImage+Extension.h"

#define XZHeadViewH 200

#define XZHeadViewMinH 64

#define XZTabBarH 44

@interface XZCustomViewController () <UITableViewDelegate>

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation XZCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _lastOffsetY = -(XZHeadViewH + XZTabBarH);
    
    // 设置顶部额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(XZHeadViewH + XZTabBarH , 0, 0, 0);
    
    XZTableView *tableView = (XZTableView *)self.tableView;
    tableView.tabBar = _titleBar;
}

-(XZTableView *)tableView {
    if (!_tableView) {
        _tableView = [[XZTableView alloc] init];
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - _lastOffsetY;
    
    CGFloat headH = XZHeadViewH - delta;
    
    if (headH < XZHeadViewMinH) {
        headH = XZHeadViewMinH;
    }
    
    _headHCons.constant = headH;
    
    // 计算透明度，刚好拖动200 - 64 136，透明度为1
    
    CGFloat alpha = delta / (XZHeadViewH - XZHeadViewMinH);
    
    // 获取透明颜色
    UIColor *alphaColor = [UIColor colorWithWhite:0 alpha:alpha];
    [_titleLabel setTextColor:alphaColor];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    
}

@end
