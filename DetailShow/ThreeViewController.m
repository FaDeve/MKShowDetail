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


    // 数据源
@property (nonatomic, strong, nonnull) NSMutableArray *sections;
@property (nonatomic, strong, nonnull) NSMutableArray *details;
@end

@implementation ThreeViewController

#pragma mark - life cycle
- (void)dealloc {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/**
 *  目前还存在问题:
 如果左边tableView执行选择代理后右边tableView滚动到相应的位置会导致Nav滚动效果
 如果判断左边tableView的事件,并且在左边tableView点击时过滤掉效果,右边tableView的contentView会显示不正确.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建左边一个tableView 右边一个tableView 然后左右相互判断
    // 创建左边的tableView
    [self setupLeftTableView];
    
    [self setupRightTableView];
    
    [self setupTabBar];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1024) {
        return self.sections.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1024) {
        return self.details.count;
    }
    return self.sections.count;
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
        cell.textLabel.text = self.details[indexPath.row];
        
        return cell;
    }else {
        static NSString *ID = @"cell11111";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                    ];
            cell.backgroundColor = [UIColor blueColor];
        }
        
        cell.textLabel.text = self.sections[indexPath.row];
        
        return cell;
    }
    
}
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1024) {
        return [NSString stringWithFormat:@"section %zd",section];
    }else {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == 1024){
        return;
    }else {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1024) {
        return 25;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
#pragma mark - 滑动处理

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    // 推拽将要结束的时候手动调一下这个方法
    [self scrollViewDidEndDecelerating:scrollView];
}
- (void)selectLeftTableViewWithScrollView:(UIScrollView *)scrollView {
    // 如果现在滑动的是左边的tableView，不做任何处理
    if ((UITableView *)scrollView == self.leftTableView) return;
    
    // 滚动右边tableView，设置选中左边的tableView某一行。indexPathsForVisibleRows属性返回屏幕上可见的cell的indexPath数组，利用这个属性就可以找到目前所在的分区
    NSInteger row = [self MinCurrentSection:self.tableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

// override
CGFloat olderTop = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag != 1024) {
        return;
    }
    // 获取当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY + (kHeadViewH+ kTitleBarH) ;
    
    CGFloat headH = kHeadViewH - delta;
    
    if (headH < kHeadViewMinH) {
        headH = kHeadViewMinH;
    }
    
    self.headHCons.constant = headH;
    
    CGFloat top = headH +kTitleBarH;
    if (top>=kTitleBarH +kHeadViewH) {
        top = kTitleBarH + kHeadViewH;
    }
    if (olderTop !=top) {
        self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
        self.leftTableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
        olderTop = top;
    }
    // 计算透明度，刚好拖动200 - 64 136，透明度为1
    
    CGFloat alpha = delta / (kHeadViewH - kHeadViewMinH);
    if (self.changeNavigationBar) {
        self.changeNavigationBar(alpha);
    }
}


#pragma mark - private
//获取当前collectionView可见内容中最小的段值
-(NSInteger)MinCurrentSection:(UITableView *)view
{
    NSArray *visibleSections = [self.tableView.indexPathsForVisibleRows valueForKey:@"section"];
    NSInteger min = [[visibleSections valueForKeyPath:@"@min.intValue"] integerValue];
    //是不是最后一个section
    NSInteger temp = min;
    if (min +1<= self.sections.count-1) {
        CGRect sectionHeaderRect = [self.tableView rectForHeaderInSection:min +1];
        CGRect rect =[self.tableView convertRect:sectionHeaderRect toView:[UIApplication sharedApplication].keyWindow];
        if (rect.origin.y<=kHeadViewMinH + kTitleBarH) {
            temp = min +1;
        }
    }
    return temp;
}


#pragma mark - lazy
-(NSMutableArray *)sections {
    if (!_sections) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 0; i< 10; i++) {
            [temp addObject:[NSString stringWithFormat:@"标题%zd",i]];
        }
        _sections = temp;
    }
    return _sections;
}

-(NSMutableArray *)details {
    if (!_details) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 0; i< 5; i++) {
            [temp addObject:[NSString stringWithFormat:@"详细内容%zd",i]];
        }
        _details = temp;
    }
    return _details;
}
@end
