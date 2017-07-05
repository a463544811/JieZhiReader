//
//  TMPTableViewCellHeightCache.m
//  MianPin
//
//  Created by carlxu on 16/10/11.
//  Copyright © 2016年 carlxu. All rights reserved.
//

#import "TJZTableViewCellHeightCache.h"

@interface TJZTableViewCellHeightCache () {
    NSMutableArray *_sections;
    NSNumber *_heightEstimated;
}

@end

@implementation TJZTableViewCellHeightCache

- (instancetype)initWithEstimatedHeight:(CGFloat)height {
    self = [super init];
    if (self) {
        _sections = [NSMutableArray new];
        _heightEstimated = [NSNumber numberWithFloat:height];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *heights = [self __heightsForSection:indexPath.section];
    if (indexPath.row < heights.count) {
        return [heights[indexPath.row] floatValue];
    }
    return [_heightEstimated floatValue];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *heights = [self __heightsForSection:indexPath.section];
    NSNumber *height = [NSNumber numberWithFloat:cell.frame.size.height];
    if (indexPath.row <= heights.count) {
        [heights setObject:height atIndexedSubscript:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *heights = [self __heightsForSection:indexPath.section];
    if (indexPath.row < heights.count) {
        NSNumber *height = heights[indexPath.row];
        if (height != _heightEstimated) {
            return [height floatValue];
        }
    }
    return UITableViewAutomaticDimension;
}

- (NSMutableArray *)__heightsForSection:(NSInteger)section {
    if (section >= _sections.count) {
        NSInteger count = section - _sections.count + 1;
        for (int i = 0; i < count; i++) {
            [_sections addObject:[NSMutableArray new]];
        }
    }
    return _sections[section];
}

- (void)invalidate {
    [_sections removeAllObjects];
}

- (void)invalidateAtIndexPath:(NSIndexPath *)indexpath {
    [self invalidateAtSection:indexpath.section row:indexpath.row];
}

- (void)invalidateAtSection:(NSInteger)section row:(NSInteger)row {
    NSMutableArray *heights = [self __heightsForSection:section];
    if (row < heights.count) {
        [heights setObject:_heightEstimated atIndexedSubscript:row];
    }
}

@end
