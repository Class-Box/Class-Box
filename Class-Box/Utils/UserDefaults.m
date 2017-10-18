//
//  UserDefaults.m
//  Class-Box
//
//  Created by sherlock on 2017/10/14.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "UserDefaults.h"

#define USERKEY @"userkey"


//用户ID
#define USER_ID @"USER_ID"

@implementation User
@end

@implementation UserDefaults

+ (User *)getUser {
    return (User *)[self getValue:USERKEY];
}

+ (NSNumber *)getUserId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
}

+ (void)setUser:(User *)user {
    [self setValue:user forKey:USERKEY];
}

+ (void)setValue:(id)value key:(NSString *)key {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (instancetype)getValue:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end
