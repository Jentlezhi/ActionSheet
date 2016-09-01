//
//  UIImage+HC.h
//  HelperCar
//
//  Created by Jentle on 16/7/26.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HC)

/**
 *  拉伸背景获得一张新的图片
 *
 *  @param name 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name;
/**
 *  平铺模式，通过重复显示指定的矩形区域来填充图
 *
 *  @param name 图片名称
 *
 *  @return 返回通过平铺模式拉伸的图片
 */
+ (instancetype)resizedByModeTileWithName:(NSString *)name;
/**
 *  拉伸背景获得一张新的图片
 *
 *  @param name         图片名称
 *  @param leftMultiple 左侧开始位置倍率（0~1）
 *  @param topMultiple  顶部开始位置倍率（0~1）
 *
 *  @return 拉伸后的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name leftWidthMultiple:(CGFloat)leftMultiple topCapHeightMultiple:(CGFloat)topMultiple;
/**
 *  创建一个指定大小的图片(等比例)
 *
 *  注意：一般用于缩略图
 *
 *  @param size 图片尺寸
 *
 *  @return 重置大小后的图片
 */
- (instancetype)resizedImageImageInAspectFitWithSize:(CGSize)size;
/**
 *  创建一个指定大小的图片（非等比例）
 *
 *  注意：一般用于缩略图
 *
 *  @param size 图片尺寸
 *
 *  @return 重置大小后的图片
 */
- (instancetype)resizedImageImageSize:(CGSize)size;

/**
 *  根据颜色返回图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return 返回指定颜色和大小的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

/**
 *  根据颜色返回指定的大小的图片
 *
 *  @param color 图片颜色
 *
 *  @return 返回指定颜色1个点的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/**
 *  根据指定大小裁剪图片
 *
 *  @param image   原图
 *  @param clipSize 裁剪尺寸
 *
 *  @return 返回裁剪后的图片
 */
+ (instancetype)clipImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)clipSize;


@end
