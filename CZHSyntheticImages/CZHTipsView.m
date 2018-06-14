//
//  CZHTipsView.m
//  SexChat
//
//  Created by 江焰 on 2018/4/2.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHTipsView.h"
#import "Header.h"
#import "AppDelegate.h"

@interface CZHTipsView ()

///<#注释#>
@property (nonatomic, weak) UILabel *tipsLabel;
///<#注释#>
@property (nonatomic, weak) UIView *tipsBottomView;

@property (nonatomic, assign) CGFloat durationTime;

@property (nonatomic, assign) dispatch_source_t timer;

@property (nonatomic, assign) BOOL canClick;

@end

@implementation CZHTipsView

+ (instancetype)tipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime withView:(UIView *)view enableClick:(BOOL)enableClick{
    static CZHTipsView *_tips = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tips = [[CZHTipsView alloc] init];
    });
    //    ONSLog(@"====%@===%@", _tips.superview, view);
    if (_tips.superview != nil && _tips.superview != view) {//如果有父视图，表示加过，直接返回
        //        ONSLog(@"====%@===%@", _tips.tipsLabel.text, _tips.tipsTitle);
        if (![string isEqualToString:_tips.tipsLabel.text]) {
            _tips.durationTime = durationTime;
            _tips.canClick = enableClick;
            
            _tips.tipsLabel.text = string;
            
        }
    } else if (_tips.superview == nil) {
        if (durationTime > 0) {
            [_tips createTime];
        }
    } else if (_tips.superview == view) {
        if (durationTime > 0) {
            [_tips createTime];
        }
    }
    
    [_tips czh_showView];
    return _tips;
}


- (instancetype)init {
    if (self = [super init]) {
        
        [self setView];
        
    }
    return self;
}

//设置默认属性值
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    _tipsTitle = @"O(∩_∩)O哈哈哈~";
    _tipsFont = CZHGlobelNormalFont(14);
    _tipsColor = CZHColor(0xffffff);
    _bottomViewColor = CZHColor(0x333333);
    _canClick = YES;
    //    _durationTime = 3;
}


- (void)setView {
    
    self.alpha = 0;
    
    UIView *tipsBottomView = [[UIView alloc] init];
    tipsBottomView.backgroundColor = _bottomViewColor;
    tipsBottomView.layer.shadowColor = CZHRGBColor(0x323232, 0.36).CGColor;
    tipsBottomView.layer.shadowOffset = CGSizeMake(1, 1);
    tipsBottomView.layer.shadowRadius = 6.0;
    tipsBottomView.layer.shadowOpacity = 1;
    [self addSubview:tipsBottomView];
    self.tipsBottomView = tipsBottomView;
    
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = _tipsFont;
    tipsLabel.textColor = _tipsColor;
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [tipsBottomView addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    
}

- (void)setTipsTitle:(NSString *)tipsTitle {
    _tipsTitle = tipsTitle;
    self.tipsLabel.text = tipsTitle;
    [self layoutSubviews];
}

- (void)setTipsFont:(UIFont *)tipsFont {
    _tipsFont = tipsFont;
    self.tipsLabel.font = tipsFont;
    //    [self layoutSubviews];
}

- (void)setTipsColor:(UIColor *)tipsColor {
    _tipsColor = tipsColor;
    self.tipsColor = tipsColor;
}


- (void)setBottomViewColor:(UIColor *)bottomViewColor {
    _bottomViewColor = bottomViewColor;
    self.tipsBottomView.backgroundColor = bottomViewColor;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxW = ScreenWidth - CZH_ScaleWidth(60);
    CGSize tipsLabelSize = [_tipsTitle czh_sizeWithFont:_tipsFont maxW:maxW];
    
    CGFloat tipsLabelX = CZH_ScaleWidth(21);
    CGFloat tipsLabelY = CZH_ScaleWidth(10);
    CGFloat tipsLabelW = tipsLabelSize.width;
    CGFloat tipsLabelH = tipsLabelSize.height;
    self.tipsLabel.frame = CGRectMake(tipsLabelX, tipsLabelY, tipsLabelW, tipsLabelH);
    
    
    
    
    CGFloat tipsBottomViewW = CGRectGetMaxX(self.tipsLabel.frame) + CZH_ScaleWidth(21);
    CGFloat tipsBottomViewH = CGRectGetMaxY(self.tipsLabel.frame) + CZH_ScaleWidth(10);
    self.tipsBottomView.frame = CGRectMake(0, 0, tipsBottomViewW, tipsBottomViewH);
    self.tipsBottomView.czh_centerX = ScreenWidth * 0.5;
    
    //获取view的控制器
    UIViewController *vc = [self View:self.superview];
    
    //    ONSLog(@"+++++%@===%@===%d", self.superview, [self View:self.superview], vc.navigationController.navigationBar.isHidden);
    
    
    
    if (self.superview == nil) {
        self.tipsBottomView.czh_centerY = ScreenHeight * 0.5;
    } else if (self.superview != nil && vc == nil) {
        self.tipsBottomView.czh_centerY = ScreenHeight * 0.5;
    } else if (vc != nil) {
        if (vc.navigationController.navigationBar.isHidden) {//控制器的导航栏被隐藏
            self.tipsBottomView.czh_centerY = ScreenHeight * 0.5;
        } else  {
            self.tipsBottomView.czh_centerY = (ScreenHeight - CZHNavigationBarHeight) * 0.5 - 32;
        }
    }
    
    
    self.tipsBottomView.layer.cornerRadius =  self.tipsBottomView.czh_height * 0.5;
    
    //    ONSLog(@"----%@+++%@", NSStringFromCGRect(self.tipsLabel.frame), NSStringFromCGRect(self.tipsBottomView.frame));
}

//可以获取到父容器的控制器的方法,就是这个黑科技.
- (UIViewController *)View:(UIView *)view{
    UIResponder *responder = view;
    //循环获取下一个响应者,直到响应者是一个UIViewController类的一个对象为止,然后返回该对象.
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (void)czh_showView {
    
    if (self.superview == nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (_durationTime <= 0) {
        
        return ;
    }
    
    [self createTime];
    
}

- (void)createTime {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(0.1* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(self.timer, start, interval, 0.0 * NSEC_PER_SEC);
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        
        self.durationTime -= 0.1;
        //        ONSLog(@"+++++++%f", self.durationTime);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.durationTime <= 0) {
                dispatch_cancel(self.timer);
                [UIView animateWithDuration:0.3 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            }
        });
    });
    //由于定时器默认是暂停的所以我们启动一下
    //启动定时器
    dispatch_resume(self.timer);
}



+ (void)czh_hideTips {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [CZHTipsView czh_hideTipsFromeView:app.window];
}

+ (void)czh_hideTipsFromeView:(UIView *)view {
    
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[CZHTipsView class]]) {
            [UIView animateWithDuration:0.3 animations:^{
                subView.alpha = 0;
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
        }
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


//默认在keywindow
+ (void)czh_showTipsViewWithString:(NSString *)string enableClick:(BOOL)enableClick {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [CZHTipsView czh_showTipsViewWithString:string durationTime:3 withView:app.window enableClick:enableClick];
}

+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime enableClick:(BOOL)enableClick {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [CZHTipsView czh_showTipsViewWithString:string durationTime:durationTime withView:app.window enableClick:enableClick];
}
//自己确定加在那个view上面
+ (void)czh_showTipsViewWithString:(NSString *)string withView:(UIView *)view enableClick:(BOOL)enableClick {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [CZHTipsView czh_showTipsViewWithString:string durationTime:3 withView:app.window enableClick:enableClick];
}


+ (void)czh_showTipsViewWithString:(NSString *)string {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [CZHTipsView czh_showTipsViewWithString:string durationTime:3 withView:app.window enableClick:YES];
}

+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [CZHTipsView czh_showTipsViewWithString:string durationTime:durationTime withView:app.window enableClick:YES];
}


+ (void)czh_showTipsViewWithString:(NSString *)string withView:(UIView *)view {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [CZHTipsView czh_showTipsViewWithString:string durationTime:3 withView:app.window enableClick:YES];
}

+ (void)czh_showTipsViewWithString:(NSString *)string durationTime:(CGFloat)durationTime withView:(UIView *)view enableClick:(BOOL)enableClick{
    
    CZHTipsView *tips = [CZHTipsView tipsViewWithString:string durationTime:(CGFloat)durationTime withView:(UIView *)view enableClick:(BOOL)enableClick];
    tips.durationTime = durationTime;
    if (!enableClick) {
        tips.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }else {
        tips.frame = CGRectZero;
    }
    tips.tipsTitle = string;
    
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [view addSubview:tips];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
