//
//  ExamViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/2.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "ExamViewController.h"
#import "TimeTableScoreViewController.h"
#import "TimeTableExamTableViewCell.h"
#import "TimeTableScoreTableViewCell.h"
#import "SemesterView.h"
#import "NetworkTool.h"

#define LOADEXAMURL [CRAWLER_URL stringByAppendingString:@"/zf/exam"]

@interface ExamViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) SemesterView *semesterView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@property (nonatomic) NSArray *data;

@end

@implementation ExamViewController

static NSString *const reuseId = @"examreuse";
static NSString *const reuseId2 = @"examreuse2";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考试";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"四六级" style:UIBarButtonItemStylePlain target:self action:@selector(checkoutScores)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(TimeTableExamTableViewCell.class) bundle:nil] forCellReuseIdentifier:reuseId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(TimeTableScoreTableViewCell.class) bundle:nil] forCellReuseIdentifier:reuseId2];
    self.tableView.tableFooterView = UIView.new;
    self.tableView.rowHeight = 80.f;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [[NetworkTool sharedNetworkTool] loadDataInfo:LOADEXAMURL parameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *data = responseObject;
        self.data = data[@"exams"];
        NSLog(@"%@",data.debugDescription);
    } failure:^(NSError * _Nullable error) {
//        [Toast showInfo:@"加载考试失败"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.semesterView removeSelectView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.semesterView hideSelectView];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark setter and getter

- (SemesterView *)semesterView {
    if (!_semesterView) {
        _semesterView = [[SemesterView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, 70)];
        
    }
    return _semesterView;
}

#pragma mark target function

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentClicked:(UISegmentedControl *)sender {
    NSUInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        self.tableView.tableHeaderView = nil;
        [self.semesterView removeSelectView];
        [self.tableView reloadData];
    } else {
        self.tableView.tableHeaderView = self.semesterView;
        [self.tableView reloadData];
    }
}

//查4，6级英语成绩
- (void)checkoutScores {
    TimeTableScoreViewController *ttsvc = [[TimeTableScoreViewController alloc] init];
    [self.navigationController pushViewController:ttsvc animated:YES];
}

#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.semesterView hideSelectView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = self.segmentView.selectedSegmentIndex;
    NSString *const reuse = index == 0 ? reuseId : reuseId2;
    TimeTableExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = self.view.backgroundColor;
    return cell;
}

@end
