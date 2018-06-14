//
//  UIImage+CZHExtension.h
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/14.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CZHExtension)


+ (UIImage *)czh_generateScreenShotImage;
/**
 * 使用视图生成图片
 */
+ (UIImage *)czh_generateImageWithView:(UIView *)view;

//生成二维码
+ (UIImage *)czh_generateQRCodeWithCodeContent:(NSString *)codeContent codeSize:(CGFloat)codeSize;

@end
