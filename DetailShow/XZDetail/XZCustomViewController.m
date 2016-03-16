//
//  XZCustomViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "XZCustomViewController.h"

#import "UIImage+Extension.h"

@interface XZCustomViewController () <UITableViewDelegate>

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation XZCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _lastOffsetY = -(kHeadViewH + kTitleBarH);
    
    // 设置顶部额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadViewH + kTitleBarH , 0, 0, 0);
    
    XZTableView *tableView = (XZTableView *)self.tableView;
    tableView.tabBar = _titleBar;
}

-(XZTableView *)tableView {
    if (!_tableView) {
        _tableView = [[XZTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.delegate = self;
        _tableView.tag = 1024;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1024) {
        // 获取当前偏移量
        CGFloat offsetY = scrollView.contentOffset.y;
        
        // 获取偏移量差值
        CGFloat delta = offsetY - _lastOffsetY;
        
        CGFloat headH = kHeadViewH - delta;
        
        if (headH < kHeadViewMinH) {
            headH = kHeadViewMinH;
        }
        
        _headHCons.constant = headH;
        
        // 计算透明度，刚好拖动200 - 64 136，透明度为1
        
        CGFloat alpha = delta / (kHeadViewH - kHeadViewMinH);
        
        // 获取透明颜色
        UIColor *alphaColor = [UIColor colorWithWhite:0 alpha:alpha];
        [_titleLabel setTextColor:alphaColor];
        
        // 设置导航条背景图片
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    }else {
        NSLog(@"其他tableView%s",__FUNCTION__);
    }
}

@end
