//
//  DiscoverMainCell.h
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/6.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscoverMainCellModel;

@protocol DiscoverMainCellDelegate<NSObject>

- (void)commentButtonClick:(NSNumber *)noteId;

- (void)userMsgClick:(NSNumber *)userId;
@end

@interface DiscoverMainCell : UITableViewCell

@property (nonatomic, weak)id<DiscoverMainCellDelegate> delegate;

- (void)setModel:(DiscoverMainCellModel *)model;

- (void)cancelGestureRecognizer;
@end
