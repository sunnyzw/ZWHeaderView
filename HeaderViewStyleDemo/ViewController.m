//
//  ViewController.m
//  HeaderViewStyleDemo
//
//  Created by SmartDoc on 16/1/16.
//  Copyright © 2016年 SmartDoc. All rights reserved.
//

#import "ViewController.h"
#import "ZWHeaderView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic,strong) ZWHeaderView * headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"下拉放大";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.table.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self.headerView = [[ZWHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 333*WIDTH/500) headerImg:@"headerImg" controller:self];
    self.headerView.headerTitleLabel.text = @"Hello world! Hello Friends!";
    self.headerView.headerTitleLabel.textColor = [UIColor yellowColor];
    self.table.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.table];
    // 记录push时导航栏的颜色
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.table) {
        //
        [self.headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
    [self.headerView setNavigationBarAlphaWithOffsetY:scrollView.contentOffset.y];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 界面消失是恢复导航栏的颜色
    [self.navigationController.navigationBar zw_reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
