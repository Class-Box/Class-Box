//
//  Timetable.h
//  Class-Box
//
//  Created by sherlock on 2017/10/15.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timetable : NSObject

//@property(nonatomic,copy)NSString *className;
//@property(nonatomic,copy)NSString *time;//第几节课
//@property(nonatomic,copy)NSString *teacherName;
//@property(nonatomic,copy)NSString *place;
//@property(nonatomic,copy)NSString *week;//那几周上课
//@property(nonatomic,copy)NSString *weekday;//周几上课

@property(nonatomic,copy)NSString *content;
@property(nonatomic)NSUInteger rowspan;
//@property(nonatomic)NSUInteger offset;//偏移量
@property(nonatomic)CGPoint place;

@end
