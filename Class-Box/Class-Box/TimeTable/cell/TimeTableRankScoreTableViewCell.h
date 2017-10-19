//
//  TimeTableRankScoreTableViewCell.h
//  Class-Box
//
//  Created by sherlock on 2017/10/19.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankScore.h"

@interface TimeTableRankScoreTableViewCell : UITableViewCell

- (void)updateView:(RankScore *)model;

@end
