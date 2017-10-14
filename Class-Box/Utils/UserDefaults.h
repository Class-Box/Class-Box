//
//  UserDefaults.h
//  Class-Box
//
//  Created by sherlock on 2017/10/14.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic)NSString *account;
@property (nonatomic)NSString *password;
@property (nonatomic)NSString *name;

@end

@interface UserDefaults : NSObject

+ (User *)getUser;

+ (void)setUser:(User *)user;

+ (void)setValue:(id)value key:(NSString *)key;

+ (instancetype)getValue:(NSString *)key;

@end
