//
//  CZHSyntheticLocalImageController.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#define MARGIN_WIDTH   CZH_ScaleWidth(10)
#define MARGIN_HEIGHT  CZH_ScaleWidth(10)


#import "CZHSyntheticLocalImageController.h"
#import "Header.h"
#import "CZHShowSyntheticImageView.h"
#import "CZHTipsView.h"

typedef NS_ENUM(NSInteger, CZHButtonType) {
    
    CZHButtonTypeChooseFirst,
    CZHButtonTypeChooseSecond,
    CZHButtonTypeChooseSynthetic
};

@interface CZHSyntheticLocalImageController ()

///底部图片
@property (nonatomic, weak) UIImageView *firstImageView;
///上面图片
@property (nonatomic, weak) UIImageView *secondImageView;
///按钮类型
@property (nonatomic, assign) CZHButtonType buttonType;
@end

@implementation CZHSyntheticLocalImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CZHColor(0xffffff);
    
    
    [self czh_setUpView];
}

- (void)czh_setUpView {
    
    [self czh_setUpButton];
    
    [self czh_setUpImageView];
}

- (void)injected
{
    NSLog(@"I've been injected: %@", self);
}

- (void)czh_setUpImageView {
    
    CGFloat containerViewX = MARGIN_WIDTH;
    CGFloat containerViewY = CZH_ScaleWidth(50);
    CGFloat containerViewW = ScreenWidth - containerViewX * 2;
    CGFloat containerViewH = ScreenHeight - CZHNavigationBarHeight - CZHTabbarHeight - containerViewY - CZH_ScaleWidth(40);
    CGRect containerViewF = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
    UIView *containerView = [[UIView alloc] init];
    containerView.frame = containerViewF;
    containerView.layer.borderWidth = 1;
    containerView.layer.borderColor = CZHColor(0x000000).CGColor;
    [self.view addSubview:containerView];
    

    UIImageView *firstImageView = [[UIImageView alloc] init];
    firstImageView.frame = containerView.bounds;
    firstImageView.backgroundColor = CZHRGBColor(0xff0000, 0.3);
    [containerView addSubview:firstImageView];
    self.firstImageView = firstImageView;
    

    CGFloat secondImageViewX = 0;
    CGFloat secondImageViewY = 0;
    CGFloat secondImageViewW = 100;
    CGFloat secondImageViewH = 100;
    CGRect secondImageViewF = CGRectMake(secondImageViewX, secondImageViewY, secondImageViewW, secondImageViewH);
    UIImageView *secondImageView = [[UIImageView alloc] init];
    secondImageView.frame = secondImageViewF;
    secondImageView.userInteractionEnabled = YES;
    secondImageView.backgroundColor = CZHRGBColor(0x00ff00, 0.3);
    [containerView addSubview:secondImageView];
    self.secondImageView = secondImageView;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [secondImageView addGestureRecognizer:pan];

    
    CGFloat firstButtonX = MARGIN_WIDTH;
    CGFloat firstButtonY = containerView.czh_bottom + CZH_ScaleWidth(5);
    CGFloat firstButtonW = ScreenWidth - firstButtonX * 2;
    CGFloat firstButtonH = CZH_ScaleWidth(30);
    CGRect firstButtonF = CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    UIButton *SyntheticButton = [self czh_quickSetUpButtonWithFrame:firstButtonF buttonType:CZHButtonTypeChooseSynthetic title:@"合成"];
    [self.view addSubview:SyntheticButton];
  
}


- (void)czh_setUpButton {
    
    CGFloat buttonWidth = (ScreenWidth - MARGIN_WIDTH * 3) * 0.5;
    CGFloat buttonHeight = CZH_ScaleWidth(30);
    
    CGFloat firstButtonX = MARGIN_WIDTH;
    CGFloat firstButtonY = MARGIN_HEIGHT;
    CGFloat firstButtonW = buttonWidth;
    CGFloat firstButtonH = buttonHeight;
    CGRect firstButtonF = CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    UIButton *firstButton = [self czh_quickSetUpButtonWithFrame:firstButtonF buttonType:CZHButtonTypeChooseFirst title:@"选择底部图片"];
    [self.view addSubview:firstButton];
    
    
    CGFloat secondButtonX = firstButton.czh_right + MARGIN_WIDTH;
    CGFloat secondButtonY = firstButtonY;
    CGFloat secondButtonW = buttonWidth;
    CGFloat secondButtonH = buttonHeight;
    CGRect secondButtonF = CGRectMake(secondButtonX, secondButtonY, secondButtonW, secondButtonH);
    UIButton *secondButton = [self czh_quickSetUpButtonWithFrame:secondButtonF buttonType:CZHButtonTypeChooseSecond title:@"选择上面图片"];
    [self.view addSubview:secondButton];
}

- (void)move:(UIPanGestureRecognizer *)gr {
    
  
    CGPoint pt = [gr translationInView:self.firstImageView];

    self.secondImageView.czh_centerX += pt.x;
    self.secondImageView.czh_centerY += pt.y;

    [gr setTranslation:CGPointZero inView:self.firstImageView];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == CZHButtonTypeChooseSynthetic) {
        
//        NSAssert(self.firstImageView.image != nil && self.secondImageView.image != nil , @"please choose picture");
        
        if (self.firstImageView.image != nil && self.secondImageView.image != nil) {//没有选择图片不能合成
            
            
            UIImage *firstImage = self.firstImageView.image;
            
            UIImage *secondImage = self.secondImageView.image;
            
            //以底部图片大小为画布创建上下文
            UIGraphicsBeginImageContext(CGSizeMake(self.firstImageView.czh_width, self.firstImageView.czh_height));
            [firstImage drawInRect:self.firstImageView.frame];//先把底部图片 画到上下文中
            [secondImage drawInRect:self.secondImageView.frame];//再把上面图片 放在上下文中
            UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
            UIGraphicsEndImageContext();//关闭上下文
            
            
            [CZHShowSyntheticImageView czh_showSyntheticImageViewWithImage:resultImg];
            
        } else {
            [CZHTipsView czh_showTipsViewWithString:@"请选选择图片"];
        }
        
    } else {
        self.buttonType = sender.tag;
        
        CZHWeakSelf(self);
        [self showImagePickerControllerWithSuccessHandler:^(UIImage *image) {//选择图片
            
            CZHStrongSelf(self);
            
            if (self.buttonType == CZHButtonTypeChooseFirst) {
                self.firstImageView.image = image;
            } else if (self.buttonType == CZHButtonTypeChooseSecond) {
                self.secondImageView.image = image;
            }
            
        }];
    }
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
