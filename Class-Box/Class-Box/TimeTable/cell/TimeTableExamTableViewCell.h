//
//  TimeTableExamTableViewCell.h
//  Class-Box
//
//  Created by sherlock on 2017/10/2.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam.h"
@interface TimeTableExamTableViewCell : UITableViewCell

- (void)updateData:(Exam *)exam;

@end
