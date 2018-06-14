//
//  CZHShowSyntheticImageView.h
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHShowSyntheticImageView : UIView

+ (instancetype)czh_showSyntheticImageViewWithImage:(UIImage *)image;

+ (instancetype)czh_showSyntheticImageViewWithImage:(UIImage *)image isScreenShot:(BOOL)isScreenShot;

@end
