//
//  RegistViewController.h
//  Class-Box
//
//  Created by sherlock on 2017/10/19.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "BaseViewController.h"

#define LOGINURL [ASERVER_URL stringByAppendingString:@"/api/login"]
#define REGISTURL [ASERVER_URL stringByAppendingString:@"/api/users"]

#import "NetworkTool.h"

@interface RegistViewController : BaseViewController

@end
