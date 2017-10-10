//
//  TimeTableDiscoverViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/4.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableDiscoverViewController.h"
#import "TimeTableDiscoverTableViewCell.h"

@interface TimeTableDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tv_class;
@property (nonatomic) UIButton *btn_add;
@property (nonatomic) UISearchController *searchController;


@end

@implementation TimeTableDiscoverViewController

static NSString *const reuseId = @"reuse";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查询";
    self.tv_class = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT - 49)];
    self.tv_class.delegate = self;
    self.tv_class.dataSource = self;
    self.tv_class.rowHeight = 80;
    [self.tv_class registerNib:[UINib nibWithNibName:@"TimeTableDiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:reuseId];
    [self.view addSubview:self.tv_class];
    
    self.btn_add = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_add setTitle:@"手动导入课程" forState:UIControlStateNormal];
    [self.btn_add setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.btn_add.frame = CGRectMake(0, S_HEIGHT - 49, S_WIDTH, 49);
    self.btn_add.layer.cornerRadius = 5;
    self.btn_add.layer.borderWidth = 1;
    self.btn_add.layer.borderColor = UIColor.lightGrayColor.CGColor;
    [self.view addSubview:self.btn_add];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.tv_class.tableHeaderView = self.searchController.searchBar;
    self.tv_class.tableFooterView = self.btn_add;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeTableDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    return cell;
}

@end
