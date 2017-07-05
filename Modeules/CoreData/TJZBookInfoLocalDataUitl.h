//
//  TJZBookInfoLocalDataUitl.h
//  JieZhiReader
//
//  Created by tjut on 17/6/29.
//  Copyright © 2017年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJZBookModel.h"
@interface TJZBookInfoLocalDataUitl : NSObject
+ (void)insertBook:(TJZBookModel *)book;

+ (NSMutableArray *)selectAllData;

+ (void)deleteBooks;

@end
