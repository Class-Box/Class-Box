//
//  MainPatchMsgController.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/17.
//  Copyright © 2017 sherlock. All rights reserved.
//



#import "BaseViewController.h"

@protocol MainPatchMsgControllerDelegate<NSObject>

- (void)completeButtonClickWithText:(NSString *)text andKey:(NSString *)key;

@end

@interface MainPatchMsgController : BaseViewController

@property (nonatomic, weak)id<MainPatchMsgControllerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title withDefaultText:(NSString *)defaultText key:(NSString *)key;

@end
