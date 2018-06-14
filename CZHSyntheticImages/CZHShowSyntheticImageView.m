//
//  CZHShowSyntheticImageView.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHShowSyntheticImageView.h"
#import "Header.h"

@interface CZHShowSyntheticImageView ()

///<#注释#>
@property (nonatomic, strong) UIImage *syntheticImage;
///<#注释#>
@property (nonatomic, weak) UIImageView *syntheticImageView;
///<#注释#>
@property (nonatomic, assign) BOOL isScreenShot;
@end

@implementation CZHShowSyntheticImageView


+ (instancetype)czh_showSyntheticImageViewWithImage:(UIImage *)image isScreenShot:(BOOL)isScreenShot {
    
    CZHShowSyntheticImageView *view = [[CZHShowSyntheticImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) syntheticImage:image isScreenShot:isScreenShot];
    
    [view czh_showView];
    
    return view;
    
}

+ (instancetype)czh_showSyntheticImageViewWithImage:(UIImage *)image {
    
    
    return [self czh_showSyntheticImageViewWithImage:image isScreenShot:NO];
}

- (instancetype)initWithFrame:(CGRect)frame syntheticImage:(UIImage *)syntheticImage isScreenShot:(BOOL)isScreenShot{
    
    if (self = [super initWithFrame:frame]) {
        
        self.syntheticImage = syntheticImage;
        self.isScreenShot = isScreenShot;
    
        CGFloat syntheticImageViewW = syntheticImage.size.width;
        CGFloat syntheticImageViewH = syntheticImage.size.height;

        if (isScreenShot == YES) {//如果是截屏的
            syntheticImageViewW = ScreenWidth * 0.5;
            syntheticImageViewH = ScreenHeight * 0.5;
        }
        
        CGFloat syntheticImageViewX = (self.czh_width - syntheticImageViewW) * 0.5;
        CGFloat syntheticImageViewY = (self.czh_height - syntheticImageViewH) * 0.5;
        CGRect syntheticImageViewF = CGRectMake(syntheticImageViewX, syntheticImageViewY, syntheticImageViewW, syntheticImageViewH);
        
        
        UIImageView *syntheticImageView = [[UIImageView alloc] init];
        
        syntheticImageView.frame = syntheticImageViewF;
        
        syntheticImageView.image = syntheticImage;
        
        [self addSubview:syntheticImageView];
        
        self.syntheticImageView = syntheticImageView;
        
        
    }
    return self;
}

- (void)czh_showView {
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.syntheticImageView.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = CZHRGBColor(0x000000, 0.6);
        self.syntheticImageView.alpha = 1;
    }];
    
    
}

- (void)czh_hideView {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.syntheticImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self czh_hideView];
    
}

@end
