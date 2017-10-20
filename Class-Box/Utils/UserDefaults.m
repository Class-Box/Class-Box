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
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
            @"des" : @"description"
    };
}


@end

@implementation UserDefaults

+ (User *)getUser {
    NSString *json = [self getValue:USERKEY];
    return [User mj_objectWithKeyValues:json];
}

+ (NSNumber *)getUserId {
    return [self getUser].id;
}

+ (NSNumber *)getUserClassId {
    return [self getUser].classId;
}

+ (void)setUser:(User *)user {
    [self setValue:user.mj_JSONString key:USERKEY];
}

+ (void)removeUser {
    [self removeValueForKey:USERKEY];
}

+ (void)removeValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (void)setValue:(id)value key:(NSString *)key {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (id)getValue:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end
