//
//  LSYReadConfig.h
//  LSYReader
//
//  Created by Labanotation on 16/5/30.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSYReadConfig : NSObject<NSCoding>
+(instancetype)shareInstance;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic,retain) UIColor *fontColor;
@property (nonatomic,retain) UIColor *theme;
@end
