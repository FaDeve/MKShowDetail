//
//  ThreeViewController.m
//  DetailShow
//
//  Created by 微指 on 16/3/7.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "ThreeViewController.h"


static NSString *const keyPath = @"contentOffset";

#define ScreenSize [UIScreen mainScreen].bounds.size


@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong,nonnull) UITableView *leftTableView;
@end

@implementation ThreeViewController

#pragma mark - life cycle
- (void)dealloc {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tableView removeObserver:self forKeyPath:keyPath];
}

/**
 *  目前还存在问题:
 如果左边tableView执行选择代理后右边tableView滚动到相应的位置会导致Nav滚动效果
 如果判断左边tableView的事件,并且在左边tableView点击时过滤掉效果,右边tableView的contentView会显示不正确.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    
    // 创建左边一个tableView 右边一个tableView 然后左右相互判断
    // 创建左边的tableView
    [self setupLeftTableView];
    
    [self setupRightTableView];
    
    [self setupTabBar];
    
    [self.tableView addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 监听tableView的contentOffset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGPoint newP = [change[@"new"] CGPointValue];
    CGPoint oldP = [change[@"old"] CGPointValue];

    if (newP.y != oldP.y) {
        
        CGFloat offsetY = newP.y;
        
        // 获取偏移量差值
        CGFloat delta = offsetY - (-(kHeadViewH + kTitleBarH));
        
        CGFloat headH = kHeadViewH - delta;
        
        if (headH < kHeadViewMinH) {
            headH = kHeadViewMinH;
        }
        
        _leftTableView.contentInset = UIEdgeInsetsMake(headH + kTitleBarH, 0, 0, 0);
        
        if (newP.y>-(kTitleBarH + kHeadViewMinH)) {
            _leftTableView.contentOffset = CGPointMake(0, -kTitleBarH - kHeadViewMinH);
        }else{
            _leftTableView.contentOffset = self.tableView.contentOffset;
        }
    }
}

#pragma mark - 创建视图
/**
 *  创建左边的tableView
 */
- (void)setupLeftTableView {
    
    self.leftTableView = ({
        
        UITableView *leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenSize.width /3, ScreenSize.height - kTitleBarH) style:UITableViewStylePlain];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        [self.view addSubview:leftTableView];
        
        leftTableView.contentInset = UIEdgeInsetsMake(self.headHCons.constant+kTitleBarH, 0, 0, 0);
        leftTableView;
    });
}
/**
 *  右边的tableView
 */
- (void)setupRightTableView {

    self.tableView.frame = CGRectMake(ScreenSize.width/3, 0, ScreenSize.width *2/3, ScreenSize.height - kTitleBarH);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

/**
 *   创建底部工具栏
 */
-(void)setupTabBar {
    UIView *tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenSize.height - kTitleBarH, ScreenSize.width, kTitleBarH)];
    tabBarView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tabBarView];
}

#pragma mark - tableView delegate&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1024) {
        return 30;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1024) {
        static NSString *ID = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                    ];
            cell.backgroundColor = [UIColor redColor];
        }
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"XZCustomViewController两个tableView%ld",indexPath.row];
        
        return cell;
    }else {
        static NSString *ID = @"cell11111";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                    ];
            cell.backgroundColor = [UIColor blueColor];
        }
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"标题%ld",indexPath.row];
        
        return cell;
    }
    
}
@end
