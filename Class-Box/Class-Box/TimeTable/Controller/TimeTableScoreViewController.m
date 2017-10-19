//
//  TimeTableScoreViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/2.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableScoreViewController.h"
#import "TimeTableRankScoreTableViewCell.h"
#import "MJExtension.h"
#import "NetworkTool.h"

#define LOADSCOREURL  [CRAWLER_URL stringByAppendingString:@"/zf/rank_exam"]

@interface TimeTableScoreViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tv_score;
@property (nonatomic) NSArray *data;

@end

@implementation TimeTableScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"四六级";
    
    self.tv_score = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT) style:UITableViewStylePlain];
    self.tv_score.delegate = self;
    self.tv_score.dataSource = self;
    [self.tv_score registerNib:[UINib nibWithNibName:@"TimeTableRankScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.tv_score.rowHeight = 120;
    self.tv_score.separatorInset = UIEdgeInsetsZero;
    self.tv_score.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tv_score];
    
    [[NetworkTool sharedNetworkTool] loadDataInfo:LOADSCOREURL parameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        self.data = dict[@"rank_exams"];
        [self.tv_score reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeTableRankScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    RankScore *score = [RankScore mj_objectWithKeyValues:self.data[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = self.view.backgroundColor;
    [cell updateView:score];
    return cell;
}

@end
