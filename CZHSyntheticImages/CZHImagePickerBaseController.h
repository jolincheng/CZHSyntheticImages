//
//  CZHImagePickerBaseController.h
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHImagePickerBaseController : UIViewController


///打开相册，选择图片回调
- (void)showImagePickerControllerWithSuccessHandler:(void(^)(UIImage *image))successHandler;

@end
