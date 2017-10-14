//
//  UserDefaults.m
//  Class-Box
//
//  Created by sherlock on 2017/10/14.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import "UserDefaults.h"

#define USERKEY @"userkey"

@implementation User
@end

@implementation UserDefaults

+ (User *)getUser {
    return [self getValue:USERKEY];
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
