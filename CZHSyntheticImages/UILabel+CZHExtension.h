//
//  UILabel+CZHExtension.h
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/14.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CZHExtension)
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  backgroundColor :  背景颜色
 *  textAliment :  文字样式
 *  shadowColor : 阴影颜色
 *  shadowOffset :  阴影偏移量
 *  text :  文本
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset text:(NSString *)text;
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  backgroundColor :  背景颜色
 *  textAliment :  文字样式
 *  text :  文本
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text;
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  text :  文本
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text;
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  backgroundColor :  背景颜色
 *  text :  文本
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor text:(NSString *)text;
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  textAliment :  文字样式
 *  text :  文本
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text;
/**
 *  快速创建label
 *  frame : frame
 *  font :  字体
 *  textColor :  字体颜色
 *  textAliment :  文字样式
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor;

/**
 *  快速创建label
 *  font :  字体
 *  textColor :  字体颜色
 */
+ (UILabel *)czh_setLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor ;
/**
 *  快速创建label
 *  font :  字体
 *  textColor :  字体颜色
 *  textAliment : 文字样式
 */
+ (UILabel *)czh_setLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment;

/**
 *  快速创建label
 *  font :  字体
 *  textColor :  字体颜色
 *  textAliment : 文字样式
 *  numberOfLines : 行数
 */
+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment numberOfLines:(NSInteger)numberOfLines text:(NSString *)text;
@end
