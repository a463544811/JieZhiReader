//
//  TJZBookModel.m
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookModel.h"

@implementation TJZBookModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"ImageURL":@"ImageURL",
             @"BookURL":@"BookURL",
             @"Info":@"Info",
             @"Author":@"Author",
             @"Publisher":@"Publisher",
             @"Title":@"Title",
             @"ISBN":@"ISBN",
             @"readPercent":@"readPercent"};
}
@end
