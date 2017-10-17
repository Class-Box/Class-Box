//
//  TimeTableDetailsView.h
//  Class-Box
//
//  Created by sherlock on 2017/9/25.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Timetable.h"

//行高
#define SECTIONHEIGHT 55
#define SECTIONNUMBER 12
#define TRANSLUCENTVIEWWIDTH 50

//上排的星期几，一个的宽度
#define SINGLETABWIDTH 57.5
#define SCROLLVIEWWIDTH SINGLETABWIDTH * 8 + TRANSLUCENTVIEWWIDTH

@protocol TimeTableDetailsViewDelegate <NSObject>



@end

@interface TimeTableDetailsView : UIView

@property(nonatomic,weak) id<TimeTableDetailsViewDelegate> delegate;

- (void)reloadData:(NSArray <Timetable *>*)data;

@end
