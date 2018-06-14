//
//  CZHTabBarController.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHTabBarController.h"
#import "CZHNavigationController.h"
#import "CZHSyntheticNetworkImageController.h"
#import "CZHSyntheticLocalImageController.h"
#import "CZHShareLocalViewController.h"

@interface CZHTabBarController ()

@end

@implementation CZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    
    // 添加所有子控制器
    [self czh_setUpAllChildViewController];
    
}


- (void)czh_setUpAllChildViewController {
    
    CZHSyntheticLocalImageController *localVc = [[CZHSyntheticLocalImageController alloc] init];
    CZHNavigationController *localNavi = [self czh_setUpOneChildViewController:localVc image:@"" selectedImage:@"" title:@"本地图片合成"];
    [self addChildViewController:localNavi];
    
    
    CZHSyntheticNetworkImageController *networkVc = [[CZHSyntheticNetworkImageController alloc] init];
    CZHNavigationController *networkNavi = [self czh_setUpOneChildViewController:networkVc image:@"" selectedImage:@"" title:@"网络图片合成"];
    [self addChildViewController:networkNavi];
    
    
    CZHShareLocalViewController *shareVc = [[CZHShareLocalViewController alloc] init];
    CZHNavigationController *shareVcNavi = [self czh_setUpOneChildViewController:shareVc image:@"" selectedImage:@"" title:@"分享本地视图"];
    [self addChildViewController:shareVcNavi];
    
}

- (CZHNavigationController *)czh_setUpOneChildViewController:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];;
    
//    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
//    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    
    CZHNavigationController *nav = [[CZHNavigationController alloc] initWithRootViewController:vc];
    
    return nav;
}

@end
