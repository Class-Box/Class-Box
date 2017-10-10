//
//  TimeTableScoreViewController.m
//  Class-Box
//
//  Created by sherlock on 2017/10/2.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableScoreViewController.h"

@interface TimeTableScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UILabel *score;

@end

@implementation TimeTableScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"四六级";
    self.score.hidden = YES;
}

- (IBAction)checkout:(id)sender {
    
}


@end
