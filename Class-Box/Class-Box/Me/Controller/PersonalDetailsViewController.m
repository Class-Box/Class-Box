//
//  PersonalDetailsViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/20.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "PersonalDetailsViewController.h"
#import "UserDefaults.h"

@interface PersonalDetailsViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic) UITableView *tv_infomation;
@property (nonatomic) NSArray *list;
@property (nonatomic) NSDictionary *map;

@end

@implementation PersonalDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    User *user = [UserDefaults getUser];
    self.list = @[@"姓名",@"邮箱",@"电话",@"学校名称",@"学院名称",@"专业名称"];
    self.map = @{@"姓名" : user.name ? user.name : @"" ,@"邮箱" : user.email ? user.email : @"" , @"电话" : user.tel ? user.tel : @"" , @"学校名称" : user.schoolName ? user.schoolName : @"浙江科技学院" ,@"学院名称" : user.instituteName ? user.instituteName : @"" , @"专业名称" : user.majorName ? user.majorName : @"" };
    
    self.tv_infomation = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT) style:UITableViewStyleGrouped];
    self.tv_infomation.delegate = self;
    self.tv_infomation.dataSource = self;
    [self.view addSubview:self.tv_infomation];
    
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSString *str = self.list[indexPath.row];
    cell.textLabel.text = str;
    cell.detailTextLabel.text = self.map[str];
    return cell;
}

@end
