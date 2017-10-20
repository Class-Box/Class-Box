//
//  TimeTableViewController.h
//  ClassBox
//
//  Created by Wrappers Zhang on 2017/9/16.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "BaseViewController.h"

@interface TimeTableViewController : BaseViewController

- (void)loadData:(NSString *)year term:(NSString *)term;

@property (nonatomic) BOOL needLoad;

@end
