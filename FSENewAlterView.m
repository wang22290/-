//
//  FSENewAlterView.m
//  FoodSafetyEducation
//
//  Created by wagn on 2019/12/18.
//  Copyright © 2019 wagn. All rights reserved.
//


#import "FSENewAlterView.h"
#import "Masonry.h"
#define KScreenW  [UIScreen mainScreen].bounds.size.width  /// 屏幕宽
#define KScreenH  [UIScreen mainScreen].bounds.size.height /// 屏幕高
@interface FSENewAlterView ()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView      *contentView;
@property (nonatomic,strong) UIView      *backView;
@property (nonatomic,strong) UILabel     *messageLabel;
@property (nonatomic,strong) UIImageView *borderImageView;
@property (nonatomic,strong) UIButton    *cancelButton;
@property (nonatomic,strong) UIButton    *confirmButton;
@property (nonatomic,assign) NSInteger    currentBtnTag;
@end



@implementation FSENewAlterView

- (instancetype)initWithmessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle block:(void (^)(NSInteger))block{
    if (self = [super init]) {
        self.buttonBlock = block;
        [self sutUpView];
        
        self.messageLabel.text = message;
        if (confirmButtonTitle.length > 0) {
            [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"取消框"] forState:UIControlStateNormal];
            [self.cancelButton setTitleColor:[UIColor colorWithRed:58/255.0 green:144/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
            
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"弹窗-开始答题"] forState:UIControlStateNormal];
            [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
            
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.borderImageView.mas_centerX).offset(0);
                make.bottom.mas_equalTo(self.borderImageView.mas_bottom).offset(-KScreenW * 0.5 * 0.4 * 0.5 * 0.3);
                make.width.mas_equalTo(KScreenW * 0.5 * 0.4);
                make.height.mas_equalTo(self.cancelButton.mas_width).multipliedBy(0.5);
            }];
            
            [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.borderImageView.mas_centerX).offset(0);
                make.bottom.mas_equalTo(self.borderImageView.mas_bottom).offset(-KScreenW * 0.5 * 0.4 * 0.5 * 0.3);
                make.width.mas_equalTo(KScreenW * 0.5 * 0.4);
                make.height.mas_equalTo(self.cancelButton.mas_width).multipliedBy(0.5);
            }];
        }else{
            [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"弹窗-开始答题"] forState:UIControlStateNormal];
            [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.borderImageView.mas_centerX).offset(0);
                make.bottom.mas_equalTo(self.borderImageView.mas_bottom).offset(-KScreenW * 0.5 * 0.4 * 0.5 * 0.3);
                make.width.mas_equalTo(KScreenW * 0.5 * 0.5);
                make.height.mas_equalTo(self.cancelButton.mas_width).multipliedBy(0.5);
            }];
            self.confirmButton.hidden = YES;
        }
    }
    return self;
}

- (void)sutUpView{
    self.frame = [UIScreen mainScreen].bounds;
  
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.6;
    _backView = backView;
    [self addSubview:_backView];
    
    UIImageView *borderImageView = [[UIImageView alloc]init];
    [borderImageView setImage:[UIImage imageNamed:@"弹框"]];
    _borderImageView = borderImageView;
    [self addSubview:_borderImageView];
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.font  = [UIFont boldSystemFontOfSize:17];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 0;
    _messageLabel = messageLabel;
    [self addSubview:_messageLabel];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 15,0)];
    cancelButton.tag = 0;
    _cancelButton = cancelButton;
    [self  addSubview:_cancelButton];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [confirmButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 15,0)];
    confirmButton.tag = 1;
    _confirmButton = confirmButton;
    [self  addSubview:_confirmButton];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self);
    }];
    
    [self.borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.width.mas_equalTo(KScreenW * 0.5);
        make.height.mas_equalTo(KScreenW * 0.5 * 0.8);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.borderImageView.mas_centerY).offset(-KScreenW * 0.5 * 0.8 * 0.15);
        make.width.mas_equalTo(KScreenW * 0.5 * 0.8 * 0.5);
    }];
    
}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [keyWindow addSubview:self];
}


- (void)buttonDidClick:(UIButton *)sender{
    if (self.buttonBlock) {
        self.buttonBlock(sender.tag);
    }
    [self dismiss];
}


#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}


@end
