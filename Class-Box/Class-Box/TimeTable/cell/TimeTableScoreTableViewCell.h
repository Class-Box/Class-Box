//
//  TimeTableScoreTableViewCell.h
//  Class-Box
//
//  Created by sherlock on 2017/10/4.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"

@interface TimeTableScoreTableViewCell : UITableViewCell

- (void)updateData:(Score *)score;

@end
