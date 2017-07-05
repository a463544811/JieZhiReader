//
//  TJZUtil.m
//  JieZhiReader
//
//  Created by tu on 2017/6/30.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZUtil.h"

@implementation TJZUtil

+ (void)didViewColor:(NSString *)color{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:color forKey:@"viewColor"];
}

+ (NSString *)viewColor{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"viewColor"];
}

+ (void)textViewBackColor:(NSString *)color{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:color forKey:@"textViewColor"];
}

+ (NSString *)textViewColor{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"textViewColor"];
}

@end
