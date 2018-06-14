//
//  CZHSyntheticNetworkImageController.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHSyntheticNetworkImageController.h"
#import "Header.h"
#import "CZHShowSyntheticImageView.h"

typedef NS_ENUM(NSInteger, CZHButtonType) {
    
    CZHButtonTypeChooseFirst,
    CZHButtonTypeChooseSecond
};

@interface CZHSyntheticNetworkImageController ()

@end

@implementation CZHSyntheticNetworkImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //适用分享视频连接的时候，需求是分享的图片需要带上播放图片，但是一般视频也只是有一个封面而已，所以需要自己把播放的图片跟封面合成一张

    [self czh_setUpView];
    
}

- (void)czh_setUpView {

    
    CGFloat SyntheticButtonX = CZH_ScaleWidth(10);
    CGFloat SyntheticButtonY = CZH_ScaleWidth(30);
    CGFloat SyntheticButtonW = ScreenWidth - SyntheticButtonX * 2;
    CGFloat SyntheticButtonH = CZH_ScaleWidth(30);
    CGRect SyntheticButtonF = CGRectMake(SyntheticButtonX, SyntheticButtonY, SyntheticButtonW, SyntheticButtonH);
    UIButton *SyntheticButton = [self czh_quickSetUpButtonWithFrame:SyntheticButtonF buttonType:CZHButtonTypeChooseFirst title:@"一张网络图片一张本地合成"];
    [self.view addSubview:SyntheticButton];
    
    
    CGFloat twoNetworkImageButtonX = CZH_ScaleWidth(10);
    CGFloat twoNetworkImageButtonY = SyntheticButton.czh_bottom + CZH_ScaleWidth(20);
    CGFloat twoNetworkImageButtonW = ScreenWidth - SyntheticButtonX * 2;
    CGFloat twoNetworkImageButtonH = CZH_ScaleWidth(30);
    CGRect twoNetworkImageButtonF = CGRectMake(twoNetworkImageButtonX, twoNetworkImageButtonY, twoNetworkImageButtonW, twoNetworkImageButtonH);
    UIButton *twoNetworkImageButton = [self czh_quickSetUpButtonWithFrame:twoNetworkImageButtonF buttonType:CZHButtonTypeChooseSecond title:@"两张网络图片合成"];
    [self.view addSubview:twoNetworkImageButton];

}

- (void)buttonClick:(UIButton *)sender {
    
    
    if (sender.tag == CZHButtonTypeChooseFirst) {
        
        [self czh_syntheticLocalAndNetWork];
        
    } else if (sender.tag == CZHButtonTypeChooseSecond) {
       
        [self czh_syntheticNetWork];
        
    }
}


- (void)czh_syntheticNetWork {
    
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

}

- (void)czh_syntheticLocalAndNetWork {
    
    NSString *url = @"http://static.yygo.tv/avatar/2/5a712bc7790f2.png";
    
    //    @"http://static.yygo.tv/avatar/2/5a5756e2dd94b.png"
    czh_dispatch_queue_async_safe(dispatch_get_global_queue(0, 0), ^{
        
        //
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        UIImage *networkImage = [UIImage imageWithData:data];
        CGFloat networkImageW = 0;
        CGFloat networkImageH = 0;
        if (networkImage.size.height > 0 && networkImage.size.width > 0) {
            
            if (networkImage.size.height > networkImage.size.width) {
                networkImageW = ScreenWidth;
                networkImageH = networkImageW * networkImage.size.height / networkImage.size.width;
            } else {
                networkImageH = ScreenWidth;
                networkImageW = networkImageH * networkImage.size.width / networkImage.size.height;
            }
        }
        
        UIImage *localImage = [UIImage imageNamed:@"share_play"];
        CGFloat localImageW = localImage.size.width;
        CGFloat localImageH = localImage.size.height;
        
        
        //固定的大小为画布创建上下文
        UIGraphicsBeginImageContext(CGSizeMake(ScreenWidth, ScreenWidth));
        
        [networkImage drawInRect:CGRectMake((ScreenWidth - networkImageW)*0.5, (ScreenWidth - networkImageH)* 0.5, networkImageW, networkImageH)];//先把网络封面图片放在下面
        
        [localImage drawInRect:CGRectMake((ScreenWidth - localImageW)*0.5, (ScreenWidth - localImageH)*0.5, localImageW, localImageH)];//再把小图放在上面
        
        //需要合成更多，继续添加
        
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
        UIGraphicsEndImageContext();//关闭上下文
        
        czh_dispatch_main_sync_safe(^{
            
            [CZHShowSyntheticImageView czh_showSyntheticImageViewWithImage:resultImage];
        });
        
        
        
        //        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //        NSString *filePath = [path stringByAppendingPathComponent:@"01.png"];
        //        [UIImagePNGRepresentation(resultlocalImage) writeToFile:filePath atomically:YES];//保存图片到沙盒
        
        
    });
    
}



- (UIButton *)czh_quickSetUpButtonWithFrame:(CGRect)frame buttonType:(CZHButtonType)buttonType title:(NSString *)title {
   
   UIButton *button = [[UIButton alloc] init];
   button.frame = frame;
   button.tag = buttonType;
   [button setTitle:title forState:UIControlStateNormal];
   [button setTitleColor:CZHColor(0xffffff) forState:UIControlStateNormal];
   button.titleLabel.font = CZHGlobelNormalFont(12);
   [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
   button.backgroundColor = CZHColor(0x000000);
   button.titleLabel.numberOfLines = 0;
   
   return button;
   
}


                   
@end
