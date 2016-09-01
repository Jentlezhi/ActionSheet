//
//  HCActionSheet.m
//  HelperCar
//
//  Created by Jentle on 16/7/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "HCActionSheet.h"
#import "UIImage+HC.h"

#define HCASAnimationDuration 0.25f
#define HCASTagBegin          10000
#define HCApplication                [UIApplication sharedApplication]
#define kWindow                       HCApplication.keyWindow
#define HCHexColor(hexColor) [self colorWithHexColorString:hexColor]
#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)
#define ALW(x)                      ((x) * kScreenWidth/750.0)
#define ALH(y)                      ((y) * kScreenHeight/1334.0)

@interface HCActionSheet()
{
    //分割线
    UILabel *_marginLine;
}

/** 按钮数组 */
@property(strong, nonatomic) NSMutableArray *btnArray;
/** 按钮个数 */
@property(assign, nonatomic) NSInteger buttonCount;
/** 按钮背景视图 */
@property(weak, nonatomic) UIView *btnView;

@end

@implementation HCActionSheet


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self basicConfig];
    }
    return self;
}

/**
 *  基本设置
 */
- (void)basicConfig{
    UIColor *bgColor = HCHexColor(@"#000000");
    self.backgroundColor = [bgColor colorWithAlphaComponent:0.1];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction{
    [self dismiss];
}

/**
 *  buttonCount的setter方法
 */
- (void)setButtonCount:(NSInteger)buttonCount{
    _buttonCount = buttonCount;
    //按钮背景视图
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = [UIColor clearColor];
    CGFloat btnViewW = kScreenWidth;
    CGFloat btnViewH = ALH(100)*buttonCount + ALH(30);
    CGFloat btnViewX = 0;
    CGFloat btnViewY = kScreenHeight + btnViewH;
    btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
    [self addSubview:btnView];
    self.btnView = btnView;
    self.btnArray = [NSMutableArray arrayWithCapacity:buttonCount];
    
    //创建按钮
    for (int i = 0; i < buttonCount; i++) {
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnArray addObject:buttonItem];
        CGFloat btnW = kScreenWidth;
        CGFloat btnH = ALH(100);
        CGFloat btnX = 0;
        CGFloat btnY = btnH*i;
        buttonItem.frame = CGRectMake(btnX, btnY, btnW, btnH);
        buttonItem.tag = HCASTagBegin + i;
        buttonItem.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [buttonItem setTitleColor:HCHexColor(@"#333333") forState:UIControlStateNormal];
        buttonItem.backgroundColor = [UIColor whiteColor];
        [buttonItem setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [buttonItem setBackgroundImage:[UIImage imageWithColor:HCHexColor(@"#F0F0F0")] forState:UIControlStateHighlighted];
        [buttonItem addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        //分割线
        UILabel *marginLine = [[UILabel alloc] init];
        marginLine.backgroundColor = HCHexColor(@"#e2e2e2");
        CGFloat marginLineW = kScreenWidth;
        CGFloat marginLineH = 0.5f;
        CGFloat marginLineX = 0;
        CGFloat marginLineY = btnH*i;
        marginLine.frame = CGRectMake(marginLineX, marginLineY, marginLineW, marginLineH);
        
        //特殊处理最后一个按钮
        if (i == buttonCount-1) {
            buttonItem.frame = CGRectMake(btnX, btnY+ALH(30), btnW, btnH);
            marginLine.frame = CGRectMake(marginLineX, marginLineY+ALH(30), marginLineW, marginLineH);
        }
        [btnView addSubview:buttonItem];
        [btnView addSubview:marginLine];
    }
}

+ (instancetype)actionSheet{
    return [[self alloc] init];
}

/**
 *  展示选择框
 */
- (void)showActionSheetWithSheetTitles:(NSArray *)titles{
    
    BOOL isAddActionSheet = NO;
    for (UIView *item in kWindow.subviews) {
        if ([item isKindOfClass:[HCActionSheet class]]) {
            isAddActionSheet = YES;
        }
    }
    if (!titles || isAddActionSheet)return;
    //设置btn个数
    self.buttonCount = titles.count;
    for (int i = 0; i < self.buttonCount; i++) {
        UIButton *item = self.btnArray[i];
        [item setTitle:titles[i] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:HCASAnimationDuration animations:^{
        UIColor *bgColor = HCHexColor(@"#000000");
        self.backgroundColor = [bgColor colorWithAlphaComponent:0.6];
        CGFloat btnViewW = kScreenWidth;
        CGFloat btnViewH = ALH(100)*self.buttonCount + ALH(30);
        CGFloat btnViewX = 0;
        CGFloat btnViewY = kScreenHeight - btnViewH;
        [kWindow addSubview:self];
        self.btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
        
    }];
    
}

- (void)dismiss{
    [UIView animateWithDuration:HCASAnimationDuration animations:^{
        UIColor *bgColor = [UIColor whiteColor];
        self.backgroundColor = [bgColor colorWithAlphaComponent:0.01];
        CGFloat btnViewW = kScreenWidth;
        CGFloat btnViewH = ALH(100)*self.buttonCount + ALH(30);
        CGFloat btnViewX = 0;
        CGFloat btnViewY = kScreenHeight + btnViewH;
        self.btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)buttonClickAction:(UIButton *)btn{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(actionSheet: clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:btn.tag - HCASTagBegin];
    }
}

- (UIColor *)colorWithHexColorString:(NSString *)hexColorString{
    
    return [self colorWithHexColorString:hexColorString alpha:1.0f];
}

- (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha
{
    if ([hexColorString length] <6){//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6){
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:alpha];
}


@end
