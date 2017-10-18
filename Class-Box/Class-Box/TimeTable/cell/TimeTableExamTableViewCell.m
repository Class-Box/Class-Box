//
//  TimeTableExamTableViewCell.m
//  Class-Box
//
//  Created by sherlock on 2017/10/2.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "TimeTableExamTableViewCell.h"

@interface TimeTableExamTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *classTime;
@property (weak, nonatomic) IBOutlet UILabel *classPlace;
@property (weak, nonatomic) IBOutlet UILabel *classSeat;
@end

@implementation TimeTableExamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateData:(Exam *)exam {
    self.className.text = exam.course_name;
    self.classTime.text = exam.time;
    self.classPlace.text = exam.place;
    self.classSeat.text = exam.seat_number;
}

@end
