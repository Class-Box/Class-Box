//
//  UserDefaults.h
//  Class-Box
//
//  Created by sherlock on 2017/10/14.
//  Copyright © 2017年 sherlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic)NSNumber *id;
@property (nonatomic)NSNumber *classId;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, copy)NSString *tel;
@property (nonatomic)NSNumber *sex;
@property (nonatomic, copy)NSString *userDescription;
@property (nonatomic)NSNumber *majorId;
@property (nonatomic, copy)NSString *majorName;
@property (nonatomic)NSNumber *instituteId;
@property (nonatomic, copy)NSString *instituteName;
@property (nonatomic)NSNumber *schoolId;
@property (nonatomic, copy)NSString *schoolName;
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *password;
@property (nonatomic, copy)NSString *name;

@end

@interface UserDefaults : NSObject

+ (User *)getUser;

+ (void)setUser:(User *)user;

+ (void)setValue:(id)value key:(NSString *)key;

+ (instancetype)getValue:(NSString *)key;

+ (NSNumber *)getUserId;

+ (NSNumber *)getUserClassId;
@end
