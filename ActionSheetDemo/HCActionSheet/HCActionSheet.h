//
//  HCActionSheet.h
//  HelperCar
//
//  Created by Jentle on 16/7/29.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCActionSheet;

@protocol HCActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(HCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface HCActionSheet : UIView

/** 代理 */
@property(weak, nonatomic) id<HCActionSheetDelegate>delegate;
/** 创建对象类方法 */
+ (instancetype)actionSheet;
/** 展示选择框 */
- (void)showActionSheetWithSheetTitles:(NSArray *)titles;
/** 移除选择框 */
- (void)dismiss;

@end
