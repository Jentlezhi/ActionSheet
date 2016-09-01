//
//  UIImage+HC.m
//  HelperCar
//
//  Created by Jentle on 16/7/26.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIImage+HC.h"

@implementation UIImage (HC)

+ (instancetype)resizedImageWithName:(NSString *)name {
    return [self resizedImageWithName:name leftWidthMultiple:0.5 topCapHeightMultiple:0.5];
}

+ (instancetype)resizedByModeTileWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imgW = image.size.width * 0.3;
    CGFloat imgH = image.size.height * 0.3;
    UIEdgeInsets edge = UIEdgeInsetsMake(imgH, imgW, imgH, imgW);
    return [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeTile];
}

+ (instancetype)resizedImageWithName:(NSString *)name leftWidthMultiple:(CGFloat)leftMultiple topCapHeightMultiple:(CGFloat)topMultiple {
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    return [image stretchableImageWithLeftCapWidth:size.width * leftMultiple topCapHeight:size.height * topMultiple];
}

- (instancetype)resizedImageImageInAspectFitWithSize:(CGSize)size {
    UIImage *newimage;
    CGSize oldsize = self.size;
    CGRect rect;
    if (size.width / size.height > oldsize.width / oldsize.height) {
        rect.size.width = size.height * oldsize.width / oldsize.height;
        rect.size.height = size.height;
        rect.origin.x = (size.width - rect.size.width) / 2;
        rect.origin.y = 0;
    } else {
        rect.size.width = size.width;
        rect.size.height = size.width * oldsize.height / oldsize.width;
        rect.origin.x = 0;
        rect.origin.y = (size.height - rect.size.height) / 2;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, size.width, size.height)); //clear background
    [self drawInRect:rect];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

- (instancetype)resizedImageImageSize:(CGSize)size {
    UIImage *newimage;
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

#pragma mark - 根据指定颜色及大小返回图片
+ (instancetype)imageWithColor:(UIColor *)color imageSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color imageSize:CGSizeMake(1.0f, 1.0f)];
}

+ (instancetype)clipImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)clipSize
{
    clipSize.height = image.size.height*(clipSize.width/image.size.width);
    UIGraphicsBeginImageContext(clipSize);
    [image drawInRect:CGRectMake(0, 0, clipSize.width, clipSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
