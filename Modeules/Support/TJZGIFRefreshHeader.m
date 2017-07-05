//
//  TDLGIFRefreshHeader.m
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/11.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#define TABLE_HEADER_IMAGES @"slice2_"
#define TABLE_HEADER_IMAGES_COUNT 6

#import "TJZGIFRefreshHeader.h"

@interface TJZGIFRefreshHeader ()

@property (nonatomic, strong) NSArray *gifImageList;

@end

@implementation TJZGIFRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    [self setImages:self.gifImageList forState:MJRefreshStatePulling];
    [self setImages:self.gifImageList forState:MJRefreshStateRefreshing];
}

- (NSArray *)gifImageList {
    if (!_gifImageList) {
        NSMutableArray *tempList = [NSMutableArray array];
        for (int i = 0; i < TABLE_HEADER_IMAGES_COUNT; i++) {
            UIImage *imgTemp = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", TABLE_HEADER_IMAGES, i]];
            [tempList addObject:imgTemp];
        }
        _gifImageList = [NSArray arrayWithArray:tempList];
    }
    
    return _gifImageList;
}

@end
