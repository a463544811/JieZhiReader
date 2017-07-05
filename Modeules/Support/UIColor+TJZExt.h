//
//  UIColor+TDLExt.h
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/10.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TJZExt)

+ (UIColor *)colorWithHex:(NSString *)string;

+ (UIColor *)colorWithRGB:(NSInteger)rgb;

+ (UIColor *)ColorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)alpha;

@end
