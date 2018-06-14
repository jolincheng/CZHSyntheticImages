//
//  UILabel+CZHExtension.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/14.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "UILabel+CZHExtension.h"

@implementation UILabel (CZHExtension)

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset numberOfLines:(NSInteger)numberOfLines text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.textAlignment = textAliment;
    label.text = text;
    label.numberOfLines = numberOfLines;
    label.shadowColor = shadowColor;
    label.shadowOffset = shadowOffset;
    if (backgroundColor == nil) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.font = font;
    label.textColor = textColor;
    
    return label;
}

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset text:(NSString *)text {
    
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:backgroundColor textAliment:textAliment shadowColor:shadowColor shadowOffset:shadowOffset numberOfLines:1 text:text];
}

+ (UILabel *)czh_czh_setLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    
    return [UILabel czh_setLabelWithFrame:CGRectZero font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:NSTextAlignmentLeft shadowColor:nil shadowOffset:CGSizeZero numberOfLines:1 text:nil];
}

+ (UILabel *)czh_setLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment{
    
    return [UILabel czh_setLabelWithFrame:CGRectZero font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:textAliment shadowColor:nil shadowOffset:CGSizeZero numberOfLines:1 text:nil];
}

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment numberOfLines:(NSInteger)numberOfLines text:(NSString *)text{
    
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:textAliment shadowColor:nil shadowOffset:CGSizeZero numberOfLines:numberOfLines text:text];
}


+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text {
    
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:backgroundColor textAliment:textAliment shadowColor:nil shadowOffset:CGSizeZero text:text];
}


+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor text:(NSString *)text {
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:backgroundColor textAliment:NSTextAlignmentLeft text:text];
}

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAliment:(NSTextAlignment)textAliment text:(NSString *)text {
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:textAliment text:text];
}

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text {
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:NSTextAlignmentLeft text:text];
}

+ (UILabel *)czh_setLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor {
    return [UILabel czh_setLabelWithFrame:frame font:font textColor:textColor backgroundColor:[UIColor clearColor] textAliment:NSTextAlignmentLeft text:nil];
}
@end
