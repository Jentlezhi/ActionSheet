//
//  ViewController.m
//  ActionSheetDemo
//
//  Created by Jentle on 16/9/1.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "HCActionSheet.h"

@interface ViewController ()<HCActionSheetDelegate>

/** 指示器 */
@property(weak, nonatomic) UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.frame = CGRectMake(0, 0, 200, 30);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"点击屏幕，显示弹框。";
    tipLabel.center = self.view.center;
    [self.view addSubview:tipLabel];
    _tipLabel = tipLabel;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HCActionSheet *actionSheet = [HCActionSheet actionSheet];
    actionSheet.delegate = self;
    [actionSheet showActionSheetWithSheetTitles:@[@"男",@"女",@"取消"]];
}
#pragma mark - <HCActionSheetDelegate>

- (void)actionSheet:(HCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _tipLabel.text = @"男";
    }else if (buttonIndex == 1){
        _tipLabel.text = @"女";
    }else{
        _tipLabel.text = @"取消";
    }
}

@end
