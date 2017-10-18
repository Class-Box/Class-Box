//
//  NoteModel.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/14.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "NoteModel.h"
#import "MJExtension.h"

@implementation NoteModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.imgs = [aDecoder decodeObjectForKey:@"imgs"];
        self.authorId = [aDecoder decodeObjectForKey:@"authorId"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.likeId = [aDecoder decodeObjectForKey:@"likeId"];
        self.courseName = [aDecoder decodeObjectForKey:@"courseName"];
        self.createdAt = [aDecoder decodeObjectForKey:@"createdAt"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_id forKey:@"id"];
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeObject:_imgs forKey:@"imgs"];
    [aCoder encodeObject:_authorId forKey:@"authorId"];
    [aCoder encodeObject:_author forKey:@"author"];
    [aCoder encodeObject:_likeId forKey:@"likeId"];
    [aCoder encodeObject:_courseName forKey:@"courseName"];
    [aCoder encodeObject:_createdAt forKey:@"createdAt"];
}
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.sssZ";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}
@end
