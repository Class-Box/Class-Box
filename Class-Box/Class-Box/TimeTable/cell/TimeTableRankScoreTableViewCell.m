//
//  TimeTableRankScoreTableViewCell.m
//  Class-Box
//
//  Created by sherlock on 2017/10/19.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableRankScoreTableViewCell.h"

@interface TimeTableRankScoreTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *listening;
@property (weak, nonatomic) IBOutlet UILabel *reading;
@property (weak, nonatomic) IBOutlet UILabel *writing;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end


@implementation TimeTableRankScoreTableViewCell

- (void)updateView:(RankScore *)model {
    self.name.text = model.name;
    self.time.text = model.exam_time;
    self.listening.text = model.hearing_score;
    self.reading.text = model.reading_score;
    self.writing.text = model.writing_score;
    self.total.text = model.score;
}

@end
