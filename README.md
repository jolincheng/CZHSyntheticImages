
![公司的项目.png](https://upload-images.jianshu.io/upload_images/6709174-4b217cb5f07b1f6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

公司的项目，求支持，如果发现什么问题，可以留言反应，感激不尽

![QQ20180614-161704.gif](https://upload-images.jianshu.io/upload_images/6709174-509eb0c4fb9f5274.gif?imageMogr2/auto-orient/strip)


```
/**合成本地图片*/
UIImage *firstImage = self.firstImageView.image;
        
UIImage *secondImage = self.secondImageView.image;
            
 //以底部图片大小为画布创建上下文
UIGraphicsBeginImageContext(CGSizeMake(self.firstImageView.czh_width, self.firstImageView.czh_height));
//先把底部图片 画到上下文中
[firstImage drawInRect:self.firstImageView.frame];
//再把上面图片 放在上下文中
[secondImage drawInRect:self.secondImageView.frame];
//从当前上下文中获得最终图片
UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
//关闭上下文   
UIGraphicsEndImageContext();  

```

```
合成网络图片
NSString *firstUrl = @"http://static.yygo.tv/avatar/2/5a712bc7790f2.png";
    
    NSString *secondUrl = @"http://static.yygo.tv/avatar/2/5a5756e2dd94b.png";
    
    //
    czh_dispatch_queue_async_safe(dispatch_get_global_queue(0, 0), ^{
    
        //
        NSData *fistData = [NSData dataWithContentsOfURL:[NSURL URLWithString:firstUrl]];
        
        UIImage *firstImage = [UIImage imageWithData:fistData];
        
        
        CGFloat firstImageW = 0;
        CGFloat firstImageH = 0;
        if (firstImage.size.height > 0 && firstImage.size.width > 0) {
            
            if (firstImage.size.height > firstImage.size.width) {
                firstImageW = ScreenWidth;
                firstImageH = firstImageW * firstImage.size.height / firstImage.size.width;
            } else {
                firstImageH = ScreenWidth;
                firstImageW = firstImageH * firstImage.size.width / firstImage.size.height;
            }
        }
        
        
        NSData *secondData = [NSData dataWithContentsOfURL:[NSURL URLWithString:secondUrl]];
        
        UIImage *secondImage = [UIImage imageWithData:secondData];
        
        
        CGFloat secondImageW = 0;
        CGFloat secondImageH = 0;
        if (secondImage.size.height > 0 && secondImage.size.width > 0) {
            
            if (secondImage.size.height > secondImage.size.width) {
                secondImageW = ScreenWidth;
                secondImageH = secondImageW * secondImage.size.height / secondImage.size.width;
            } else {
                secondImageH = ScreenWidth;
                secondImageW = secondImageH * secondImage.size.width / secondImage.size.height;
            }
        }
        

        //固定的大小为画布创建上下文
        UIGraphicsBeginImageContext(CGSizeMake(ScreenWidth, ScreenWidth));
        
        [firstImage drawInRect:CGRectMake((ScreenWidth - firstImageW)*0.5, (ScreenWidth - firstImageH)* 0.5, firstImageW, firstImageH)];//先把网络封面图片放在下面
        
        [secondImage drawInRect:CGRectMake((ScreenWidth - secondImageW * 0.5)*0.5, (ScreenWidth - secondImageH * 0.5)*0.5, secondImageW * 0.5, secondImageH * 0.5)];//再把小图放在上面
        
        //需要合成更多，继续添加
        
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
        UIGraphicsEndImageContext();//关闭上下文
        
        czh_dispatch_main_sync_safe(^{
        
            [CZHShowSyntheticImageView czh_showSyntheticImageViewWithImage:resultImage];
        });
    
    
    });

```

```
//把视图生成图片
+ (UIImage *)czh_generateImageWithView:(UIView *)view {
    
    CGSize size = view.bounds.size;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

```

```
截图功能，首先监听通知
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

然后获取当前页面生成图片
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

```
[博客地址](https://blog.csdn.net/HurryUpCheng)
[简书地址](https://www.jianshu.com/u/2add458bf239)
