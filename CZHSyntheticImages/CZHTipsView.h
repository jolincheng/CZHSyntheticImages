//
//  CZHTipsView.h
//  SexChat
//
//  Created by 江焰 on 2018/4/2.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CZHTipsView : UIView

///标题
@property (nonatomic, strong) NSString *tipsTitle;
///提示字体大小
@property (nonatomic, strong) UIFont *tipsFont;
///字体颜色
@property (nonatomic, strong) UIColor *tipsColor;
///底部view的颜色
@property (nonatomic, strong) UIColor *bottomViewColor;

//+ (instancetype)tipsView;

- (void)czh_show;

///和显示的view是同一个
+ (void)czh_hideTipsFromeView:(UIView *)view;
//默认在keywindow
+ (void)czh_showTipsViewWithString:(NSString *)string enableClick:(BOOL)enableClick;

+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime enableClick:(BOOL)enableClick;
//自己确定加在那个view上面
+ (void)czh_showTipsViewWithString:(NSString *)string withView:(UIView *)view enableClick:(BOOL)enableClick;
//默认在keywindow
+ (void)czh_showTipsViewWithString:(NSString *)string;

+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime;
//自己确定加在那个view上面
+ (void)czh_showTipsViewWithString:(NSString *)string withView:(UIView *)view;

+ (void)czh_hideTips;

/**
 * 自己确定加在那个view上面,持续几秒消失
 *
 * string : 提示文字
 * durationTime : 持续时间, 为负数的时候不消失，需要手动调用隐藏
 * view : 显示在哪个view上面
 * enableClick : 默认是yes，如果为no，tips显示的时候不可点击
 */
+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime withView:(UIView *)view enableClick:(BOOL)enableClick;

@end
