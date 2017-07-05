//
//  UIColor+TDLExt.m
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/10.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#import "UIColor+TJZExt.h"

@implementation UIColor (TJZExt)

+ (UIColor *)colorWithHex:(NSString *)string {
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF) / 255.0f;
    float green = ((baseValue >> 16) & 0xFF) / 255.0f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSInteger)rgbaValue {
    CGFloat alpha = (CGFloat)((rgbaValue & 0xFF000000) >> 24) / 255.0f;
    CGFloat red = (CGFloat)((rgbaValue & 0x00FF0000) >> 16) / 255.0f;
    CGFloat green = (CGFloat)((rgbaValue & 0x0000FF00) >> 8) / 255.0f;
    CGFloat blue = (CGFloat)(rgbaValue & 0x000000FF) / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)ColorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue {
    return [UIColor colorWithRed:(red) / 255.0 green:(green) / 255.0 blue:(blue) / 255.0 alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00) >> 8) / 255.0 blue:(rgbValue & 0xFF) / 255.0 alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)_alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00) >> 8) / 255.0 blue:(rgbValue & 0xFF) / 255.0 alpha:_alpha];
}


@end
