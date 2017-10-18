//
//  NoteCommentModel.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/18.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "NoteCommentModel.h"
#import "MJExtension.h"

@implementation NoteCommentModel

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
