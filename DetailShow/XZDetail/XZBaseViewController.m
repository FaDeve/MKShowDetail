//
//  XZBaseViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "XZBaseViewController.h"
#import "XZCustomViewController.h"
#import "XZCustomTableViewController.h"

@interface XZBaseViewController ()<UIScrollViewDelegate>
/**
 *  标题内容
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  选择栏
 */
@property (weak, nonatomic) IBOutlet UIView *titleBar;

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@property (nonatomic, weak) UIButton *selectedBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewCons;

// 头像控件
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

// 明信片控件
@property (weak, nonatomic) IBOutlet UIImageView *cardView;
/**
 *  商户名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation XZBaseViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:@"XZBaseViewController" bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    _contentView.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpNav];

}

-(void)setIcon:(UIImage *)iconImage card:(UIImage *)cardImage shopName:(NSString *)name withControllers:(NSArray *)vcs {
   
    self.iconView.image = iconImage;
    
    self.cardView.image = cardImage;
    self.nameLabel.text = name;
    
    // 设置子控制器
    [self setUpChildControlllerWithControllers:vcs];
    
    // 设置titleBar
    [self setupTitleBarWithControllers:vcs];
}

// 设置导航条
- (void)setUpNav
{
    // 导航条背景透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航条中间view
    UILabel *label = [[UILabel alloc] init];
    
    _titleLabel = label;
    
    label.font = [UIFont  boldSystemFontOfSize:18];
    
    label.text = self.title;
    
    [label setTextColor:[UIColor colorWithWhite:1 alpha:0]];
    
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
}

// 设置子控制器
- (void)setUpChildControlllerWithControllers:(NSArray *)vcs
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger index = 0;
    CGRect frame = [UIScreen mainScreen].bounds;
    for (XZCustomTableViewController *personChildVc in vcs) {
        
        // 传递tabBar，用来判断点击了哪个按钮
        personChildVc.titleBar = _titleBar;
        
        // 传递高度约束，用来移动头部视图
        personChildVc.headHCons = _headViewCons;
        
        // 传递标题控件，设置文字透明
        personChildVc.titleLabel = _titleLabel;
        frame.origin.x = index *size.width;
        personChildVc.view.frame = frame;
        [_contentView addSubview:personChildVc.view];
        index++;
    }
    
    _contentView.contentSize = CGSizeMake(self.childViewControllers.count * size.width, size.height);
}

// 设置tabBar
- (void)setupTitleBarWithControllers:(NSArray *)vcs
{
    // 遍历子控制器
    
    for (UIViewController *childVc in vcs) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = _titleBar.subviews.count;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setTitle:childVc.title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [_titleBar addSubview:btn];
        
        
    }
    
}
- (void)btnClick:(UIButton *)btn
{
    
    if (btn == _selectedBtn) {
        return;
    }

    // 上次选中的视图
    UITableView *lastVcView = (UITableView *)[self.childViewControllers[_selectedBtn.tag] view];

    
    // 选中按钮
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    // 切换内容视图显示
    UITableViewController *vc = self.childViewControllers[btn.tag];
    
    [_contentView setContentOffset:CGPointMake(vc.view.frame.origin.x, 0)];
    
    
    // 设置tableView的滚动区域
    if (lastVcView.contentOffset.y>-108) {
        vc.tableView.contentOffset = CGPointMake(0, -108);
    }else{
        vc.tableView.contentOffset = lastVcView.contentOffset;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    // 布局tabBar子控件位置
    NSUInteger count = _titleBar.subviews.count;
    
    CGFloat btnW = self.view.bounds.size.width / count;
    
    CGFloat btnH = _titleBar.bounds.size.height;
    
    CGFloat btnX = 0;
    
    CGFloat btnY = 0;
    
    for (int i = 0; i < count; i++) {
        
        btnX = i * btnW;
        
        UIView *childV = _titleBar.subviews[i];
        
        childV.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSUInteger page = scrollView.contentOffset.x / screenSize.width;
    NSLog(@"page===>%zd",page);
    UIButton *btn = _titleBar.subviews[page];
    [self btnClick:btn];
}
@end
