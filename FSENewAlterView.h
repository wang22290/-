//
//  FSENewAlterView.h
//  FoodSafetyEducation
//
//  Created by wagn on 2019/12/18.
//  Copyright © 2019 wagn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSENewAlterView : UIView
@property(nonatomic, copy) void (^buttonBlock) (NSInteger index);

- (instancetype)initWithmessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle block:(void (^) (NSInteger index))block;

- (void)show;
@end

NS_ASSUME_NONNULL_END
