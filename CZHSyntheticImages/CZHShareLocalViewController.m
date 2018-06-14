//
//  CZHShareLocalViewController.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/14.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHShareLocalViewController.h"
#import "Header.h"
#import "CZHShowSyntheticImageView.h"
#import "UIImage+CZHExtension.h"

@interface CZHShareLocalViewController ()
///<#注释#>
@property (nonatomic, weak) UIImageView *headIconimageView;
///<#注释#>
@property (nonatomic, weak) UIView *qrCodeView;
///<#注释#>
@property (nonatomic, weak) UIImageView *qrCodeImageView;
///<#注释#>
@property (nonatomic, weak) UILabel *nicknameLabel;
///<#注释#>
@property (nonatomic, weak) UIImageView *prettyLogoImageView;
///<#注释#>
@property (nonatomic, weak) UILabel *idNumberLabel;
///<#注释#>
@property (nonatomic, weak) UILabel *fansLabel;
///<#注释#>
@property (nonatomic, weak) UILabel *charmLabel;
///<#注释#>
@property (nonatomic, weak) UILabel *tipLabel;
@end

@implementation CZHShareLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CZHColor(0xffffff);
    
    [self czh_setUpView];
    
    [self czh_setData];
    
    [self czh_setUpNavigationBar];
}

- (void)czh_setUpNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击分享" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    
}

- (void)buttonClick {
    
    UIImage *image = [UIImage czh_generateImageWithView:self.view];
    
    [CZHShowSyntheticImageView czh_showSyntheticImageViewWithImage:image];
    
}



- (void)czh_setData {
    
    
    self.headIconimageView.image = [UIImage imageNamed:@"1"];
    
    self.nicknameLabel.text = @"哈哈哈";
    
    self.idNumberLabel.text = @"ID:123456";
    
    self.fansLabel.text = @"粉丝:1234";
    
    self.charmLabel.text = @"魅力:1234";
    
    UIImage *image = [UIImage czh_generateQRCodeWithCodeContent:@"https://github.com/jolincheng" codeSize:CZH_ScaleWidth(90)];
    self.qrCodeImageView.image = image;
}


- (void)czh_setUpView {
    
    UIImageView *headIconimageView = [[UIImageView alloc] init];
    headIconimageView.contentMode = UIViewContentModeScaleAspectFill;
    headIconimageView.clipsToBounds = YES;
    [self.view addSubview:headIconimageView];
    self.headIconimageView = headIconimageView;
    
    
    UIView *qrCodeView = [[UIView alloc] init];
    qrCodeView.backgroundColor = CZHColor(0xffffff);
    [self.view addSubview:qrCodeView];
    self.qrCodeView = qrCodeView;
    
    
    UIImageView *qrCodeImageView = [[UIImageView alloc] init];
    qrCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    qrCodeImageView.backgroundColor = [UIColor redColor];
    [qrCodeView addSubview:qrCodeImageView];
    self.qrCodeImageView = qrCodeImageView;
    
    
    UILabel *nicknameLabel = [UILabel czh_setLabelWithFrame:CGRectZero font:CZHGlobelNormalFont(16) textColor:CZHColor(0x000000) textAliment:NSTextAlignmentCenter text:nil];
    [self.view addSubview:nicknameLabel];
    self.nicknameLabel = nicknameLabel;
    

    
    UILabel *idNumberLabel = [UILabel czh_setLabelWithFrame:CGRectZero font:CZHGlobelNormalFont(13) textColor:CZHColor(0x000000) textAliment:NSTextAlignmentCenter text:nil];
    [self.view addSubview:idNumberLabel];
    self.idNumberLabel = idNumberLabel;
    
    
    UILabel *fansLabel = [UILabel czh_setLabelWithFrame:CGRectZero font:CZHGlobelNormalFont(14) textColor:CZHColor(0xffffff) backgroundColor:CZHColor(0x000000) textAliment:NSTextAlignmentCenter text:nil];
    [self.view addSubview:fansLabel];
    self.fansLabel = fansLabel;
    
    
    UILabel *charmLabel = [UILabel czh_setLabelWithFrame:CGRectZero font:CZHGlobelNormalFont(14) textColor:CZHColor(0xffffff) backgroundColor:CZHColor(0xF578B3) textAliment:NSTextAlignmentCenter text:nil];
    [self.view addSubview:charmLabel];
    self.charmLabel = charmLabel;
    
    
    UILabel *tipLabel = [UILabel czh_setLabelWithFrame:CGRectZero font:CZHGlobelNormalFont(12) textColor:CZHColor(0x999999) textAliment:NSTextAlignmentCenter text:@"长按图片，识别二维码，和她一对一私密视频聊天"];
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
 
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.headIconimageView.frame = CGRectMake(0, 0, ScreenWidth, CZH_ScaleWidth(300));
    
    
    CGFloat qrCodeViewW = CZH_ScaleWidth(100);
    CGFloat qrCodeViewH = CZH_ScaleWidth(100);
    CGFloat qrCodeViewY = self.headIconimageView.czh_bottom - qrCodeViewH * 0.5;
    CGFloat qrCodeViewX = (self.view.czh_width - qrCodeViewW) * 0.5;
    CGRect qrCodeViewF = CGRectMake(qrCodeViewX, qrCodeViewY, qrCodeViewW, qrCodeViewH);
    self.qrCodeView.frame = qrCodeViewF;
    
    CGFloat qrCodeImageViewX = CZH_ScaleWidth(5);
    CGFloat qrCodeImageViewY = CZH_ScaleWidth(5);
    CGFloat qrCodeImageViewW = self.qrCodeView.czh_width - qrCodeImageViewX * 2;
    CGFloat qrCodeImageViewH = self.qrCodeView.czh_height - qrCodeImageViewY * 2;
    CGRect qrCodeImageViewF = CGRectMake(qrCodeImageViewX, qrCodeImageViewY, qrCodeImageViewW, qrCodeImageViewH);
    self.qrCodeImageView.frame = qrCodeImageViewF;
    
    
    
    CGFloat nicknameLabelX = 0;
    CGFloat nicknameLabelY = self.qrCodeView.czh_bottom + CZH_ScaleWidth(5);
    CGFloat nicknameLabelW = self.view.czh_width;
    CGFloat nicknameLabelH = CZH_ScaleWidth(17);
    CGRect nicknameLabelF = CGRectMake(nicknameLabelX, nicknameLabelY, nicknameLabelW, nicknameLabelH);
    self.nicknameLabel.frame = nicknameLabelF;

    
    CGFloat idNumberLabelX = 0;
    CGFloat idNumberLabelY = self.qrCodeView.czh_bottom + CZH_ScaleWidth(36);
    CGFloat idNumberLabelW = self.view.czh_width;
    CGFloat idNumberLabelH = CZH_ScaleWidth(14);
    CGRect idNumberLabelF = CGRectMake(idNumberLabelX, idNumberLabelY, idNumberLabelW, idNumberLabelH);
    self.idNumberLabel.frame = idNumberLabelF;
    
    
    CGFloat fansLabelW = CZH_ScaleWidth(90);
    CGFloat fansLabelH = CZH_ScaleWidth(25);
    CGFloat fansLabelX = self.view.czh_width * 0.5 - fansLabelW - CZH_ScaleWidth(7.5);
    CGFloat fansLabelY = self.qrCodeView.czh_bottom + CZH_ScaleWidth(62);
    CGRect fansLabelF = CGRectMake(fansLabelX, fansLabelY, fansLabelW, fansLabelH);
    self.fansLabel.frame = fansLabelF;
    [self.fansLabel czh_cornerAllCornersWithCornerRadius:fansLabelH* 0.5];
    
    CGFloat charmLabelW = fansLabelW;
    CGFloat charmLabelH = fansLabelH;
    CGFloat charmLabelX = self.view.czh_width * 0.5 + CZH_ScaleWidth(7.5);
    CGFloat charmLabelY = fansLabelY;
    CGRect charmLabelF = CGRectMake(charmLabelX, charmLabelY, charmLabelW, charmLabelH);
    self.charmLabel.frame = charmLabelF;
    [self.charmLabel czh_cornerAllCornersWithCornerRadius:charmLabelH* 0.5];
    
    CGFloat tipLabelX = 0;
    CGFloat tipLabelY = self.qrCodeView.czh_bottom + CZH_ScaleWidth(106);
    CGFloat tipLabelW = self.view.czh_width;
    CGFloat tipLabelH = CZH_ScaleWidth(13);
    CGRect tipLabelF = CGRectMake(tipLabelX, tipLabelY, tipLabelW, tipLabelH);
    self.tipLabel.frame = tipLabelF;
    
    
}

@end
