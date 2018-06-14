//
//  UIImage+CZHExtension.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/14.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "UIImage+CZHExtension.h"

@implementation UIImage (CZHExtension)



////截取当前屏幕
+ (UIImage *)czh_generateScreenShotImage {

    CGSize imageSize = CGSizeZero;
    imageSize = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
            
        } else {
            
            [window.layer renderInContext:context];
            
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    
    return [UIImage imageWithData:imageData];

}


+ (UIImage *)czh_generateImageWithView:(UIView *)view {
    
    CGSize size = view.bounds.size;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//生成二维码
+ (UIImage *)czh_generateQRCodeWithCodeContent:(NSString *)codeContent codeSize:(CGFloat)codeSize {
    
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSString *dataString = codeContent;
    
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(codeSize/CGRectGetWidth(extent), codeSize/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


@end
