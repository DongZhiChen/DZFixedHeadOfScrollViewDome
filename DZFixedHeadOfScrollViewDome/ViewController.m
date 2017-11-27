//
//  ViewController.m
//  DZFixedHeadOfScrollViewDome
//
//  Created by iMac on 2017/11/27.
//  Copyright © 2017年 ChenDongZhi. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "DZFixedHeadOfScrollView.h"

@interface ViewController ()
@property (nonatomic, retain) UITableView *tableView1;
@property (nonatomic, retain) UITableView *tableView2;
@property (nonatomic, retain) UIScrollView *SV1;
@property (nonatomic, retain) UIScrollView *SV_Content;
@end

@implementation ViewController
- (UITableView *)tableView1 {
    if (_tableView1 == nil) {
        _tableView1 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView1;
}
- (UITableView *)tableView2 {
    if (_tableView2 == nil) {
        _tableView2 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView2;
}
- (UIScrollView *)SV1 {
    if (_SV1 == nil) {
        _SV1 = [[UIScrollView alloc] init];
    }
    return _SV1;
}

- (UIScrollView *)SV_Content {
    if (_SV_Content == nil) {
        _SV_Content = [[UIScrollView alloc] init];
    }
    return _SV_Content;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 200)];
    vvv.backgroundColor  =[UIColor blueColor];
    
    DZFixedHeadOfScrollViewItem *item1 = [[DZFixedHeadOfScrollViewItem alloc] initWithScrollView:self.tableView1 andTitle:@"item1"];
    DZFixedHeadOfScrollView *view = [[DZFixedHeadOfScrollView alloc] init];
    view.headerView = vvv;
    view.items = @[item1];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
