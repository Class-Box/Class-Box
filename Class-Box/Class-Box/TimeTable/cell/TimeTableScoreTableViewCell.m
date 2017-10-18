//
//  TimeTableScoreTableViewCell.m
//  Class-Box
//
//  Created by sherlock on 2017/10/4.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableScoreTableViewCell.h"

@interface TimeTableScoreTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *classScore;
@property (weak, nonatomic) IBOutlet UILabel *classJd;
@property (weak, nonatomic) IBOutlet UILabel *classXf;

@end

@implementation TimeTableScoreTableViewCell

- (void)updateData:(Score *)score {
    self.className.text = score.name;
    self.classScore.text = score.score;
    self.classJd.text = score.grade_point;
    self.classXf.text = score.credot;
}

@end
