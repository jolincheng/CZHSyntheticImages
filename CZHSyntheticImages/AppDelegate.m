//
//  AppDelegate.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "AppDelegate.h"
#import "CZHTabBarController.h"
#import "UIImage+CZHExtension.h"
#import "CZHShowSyntheticImageView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[CZHTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    //监听截图通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    return YES;
}

- (void)userDidTakeScreenshot:(NSNotification *)noti {
    
    NSLog(@"检测到截屏");
    //
    UIImage *image = [UIImage czh_generateScreenShotImage];
    
    [CZHShowSyntheticImageView czh_showSyntheticImageViewWithImage:image isScreenShot:YES];
    
}






@end
