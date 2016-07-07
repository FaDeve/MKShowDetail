//
//  XZBaseViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "XZBaseViewController.h"
#import "XZCustomViewController.h"

static NSString *const keyPath = @"center";

@interface XZBaseViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UILabel *titleLabel;    ///< 标题内容
@property (weak, nonatomic) IBOutlet UIView *titleBar;  ///< 选择栏
@property (weak, nonatomic) IBOutlet UIScrollView *contentView; ///盛放滚动控制器的视图
@property (nonatomic, weak) UIButton *selectedBtn;  ///< 当前选中的button
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewCons;  ///< 头部视图高度


@end

@implementation XZBaseViewController

#pragma mark - lifecycle
-(void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self.titleBar forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSLog(@"exception:%@",exception);
    } @finally {
        NSLog(@"finally");
    }
}

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
    
    // 接收按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserverForName:XZClickBtnNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        UIButton *clickBtnObjc = note.userInfo[XZClickBtnObjcKey];
        [self btnClick:clickBtnObjc];
    }];
    
    [self.titleBar addObserver:self
                    forKeyPath:keyPath
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
}

#pragma mark - Public

- (void)configTitleBarWithButtonType:(nonnull UIButton *)showBtn showControllers:(nonnull NSArray *)vcs;{
    // 设置子控制器
    [self setUpChildControlllerWithControllers:vcs];
    
    // 设置titleBar
    [self setupTitleBarWithControllers:vcs buttonType:showBtn];
}

#pragma mark - Private

// 设置子控制器
- (void)setUpChildControlllerWithControllers:(NSArray *)vcs
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger index = 0;
    CGRect frame = [UIScreen mainScreen].bounds;
    for (XZCustomViewController *personChildVc in vcs) {
        
        // 传递tabBar，用来判断点击了哪个按钮
        personChildVc.titleBar = _titleBar;
        
        // 传递高度约束，用来移动头部视图
        personChildVc.headHCons = _headViewCons;
        
        // 传递标题控件，设置文字透明
        personChildVc.titleLabel = _titleLabel;
        frame.origin.x = index *size.width;
        personChildVc.view.frame = frame;
        [_contentView addSubview:personChildVc.view];
        [self addChildViewController:personChildVc];
        index++;
    }
    
    _contentView.contentSize = CGSizeMake(vcs.count * size.width, size.height);
}

// 设置tabBar
- (void)setupTitleBarWithControllers:(NSArray *)vcs buttonType:(UIButton *)showBtn
{
    // 遍历子控制器
    
    for (UIViewController *childVc in vcs) {
        
        UIButton *btn = [UIButton buttonWithType:showBtn.buttonType];
        
        btn.titleLabel.font = showBtn.titleLabel.font;
        [btn setTitleColor:[showBtn titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
        [btn setTitleColor:[showBtn titleColorForState:UIControlStateSelected] forState:UIControlStateSelected];
        [btn setImage:[showBtn imageForState:UIControlStateNormal] forState:UIControlStateNormal];
        [btn setImage:[showBtn imageForState:UIControlStateSelected] forState:UIControlStateSelected];
        
        btn.tag = _titleBar.subviews.count;
        [btn setTitle:childVc.title forState:UIControlStateNormal];
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
    
    // 选中按钮
    _selectedBtn.selected = NO;
    btn.selected = YES;
    
    // 切换内容视图显示
    UITableViewController *vc = self.childViewControllers[btn.tag];
    
    [_contentView setContentOffset:CGPointMake(vc.view.frame.origin.x, 0)];
    
    if (_selectedBtn == nil) {
        vc.tableView.contentOffset = CGPointMake(0, -CGRectGetMaxY(self.titleBar.frame));
    }
    _selectedBtn = btn;
}

#pragma mark - NSNotification
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:keyPath]) {
        return;
    }
    
    for (NSInteger i = 0; i< self.childViewControllers.count; i++) {
        if (i != self.selectedBtn.tag) {
            XZCustomViewController *vc = self.childViewControllers[i];
            vc.tableView.contentOffset = CGPointMake(0, - CGRectGetMaxY(self.titleBar.frame));
        }
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
#pragma mark - Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSUInteger page = scrollView.contentOffset.x / screenSize.width;
    UIButton *btn = _titleBar.subviews[page];
    [self btnClick:btn];
}
@end
