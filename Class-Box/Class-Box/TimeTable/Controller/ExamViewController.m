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
#import "MJExtension.h"
#import "Score.h"

#define LOADEXAMURLA(xnd,xqd) [CRAWLER_URL stringByAppendingFormat:@"/zf/exam?xnd=%@&xqd=%@",xnd,xqd]
#define LOADEXAMURL [CRAWLER_URL stringByAppendingFormat:@"/zf/exam"]
#define LOADSCOREURLA(xnd,xqd) [CRAWLER_URL stringByAppendingFormat:@"/zf/grade?ddlXN=%@&ddlXQ=%@",xnd,xqd]
#define LOADSCOREURL [CRAWLER_URL stringByAppendingFormat:@"/zf/grade"]

@interface ExamViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) SemesterView *semesterView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@property (nonatomic) NSArray *dataExam;
@property (nonatomic) NSArray *dataScore;

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
    self.tableView.tableHeaderView = self.semesterView;
    self.tableView.tableFooterView = UIView.new;
    self.tableView.rowHeight = 80.f;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [[NetworkTool sharedNetworkTool] loadDataInfo:LOADEXAMURL parameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *data = responseObject;
        self.dataExam = data[@"exams"];
    } failure:^(NSError * _Nullable error) {
//        [Toast showInfo:@"加载考试失败"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.semesterView removeSelectView];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark setter and getter

- (SemesterView *)semesterView {
    if (!_semesterView) {
        _semesterView = [[SemesterView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, 70)];
        
        __weak typeof(self) weakself = self;
        _semesterView.btnClicked = ^(NSString *year, NSString *term) {
            
            NSInteger index = weakself.segmentView.selectedSegmentIndex;
            NSString *URL = index == 0 ? LOADEXAMURLA(year,term) : LOADSCOREURLA(year, term);
            [[NetworkTool sharedNetworkTool] loadDataInfo:URL parameters:nil success:^(id  _Nullable responseObject) {
                if (index == 0) {
                    weakself.dataExam = responseObject[@"exams"];
                } else {
                    weakself.dataScore = responseObject[@"grades"];
                }
                
                [weakself.tableView reloadData];
            } failure:^(NSError * _Nullable error) {
                
            }];
            
        };
    }
    return _semesterView;
}

#pragma mark target function

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentClicked:(UISegmentedControl *)sender {
    [self.tableView reloadData];
//    NSUInteger index = sender.selectedSegmentIndex;
//    if (index == 0) {
//        self.tableView.tableHeaderView = nil;
//        [self.semesterView removeSelectView];
//        [self.tableView reloadData];
//    } else {
//        self.tableView.tableHeaderView = self.semesterView;
//        [self.tableView reloadData];
//    }
}

//查4，6级英语成绩
- (void)checkoutScores {
    TimeTableScoreViewController *ttsvc = [[TimeTableScoreViewController alloc] init];
    [self.navigationController pushViewController:ttsvc animated:YES];
}

#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *data = self.segmentView.selectedSegmentIndex == 0 ? self.dataExam : self.dataScore;
    return data.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = self.segmentView.selectedSegmentIndex;
    if (index == 0) {
        TimeTableExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.view.backgroundColor;
        NSDictionary *info= self.dataExam[indexPath.row];
        Exam *exam = [Exam mj_objectWithKeyValues:info];
        [cell updateData:exam];
        return cell;
    } else {
        TimeTableScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId2 forIndexPath:indexPath];
        NSDictionary *info = self.dataScore[indexPath.row];
        Score *score = [Score mj_objectWithKeyValues:info];
        [cell updateData:score];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.view.backgroundColor;
        return cell;
    }
}

@end
