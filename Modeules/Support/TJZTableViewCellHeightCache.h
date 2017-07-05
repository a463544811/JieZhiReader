//
//  TMPTableViewCellHeightCache.h
//  MianPin
//
//  Created by carlxu on 16/10/11.
//  Copyright © 2016年 carlxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 Preface & puppose: it's really a shit that apple developers didn't do this, and it troubles me a lot.
 It's really not a big deal, but it's still very important. Because with dynamic tableviewcell height,
 the tableview might scroll jumpy. The solution acorrding to the defautl behavior is to calculate the
 height before displaying. BUT, why don't they just store the height of each cell after displaying it!!!
 And that's why I created this height cache.
 
 Usage: it's simple, just call the 2 method in corresponding tableviewdelegate implementation.
 */

@interface TJZTableViewCellHeightCache : NSObject

- (instancetype)initWithEstimatedHeight:(CGFloat)height;

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)invalidate;
- (void)invalidateAtIndexPath:(NSIndexPath *)indexpath;
- (void)invalidateAtSection:(NSInteger)section row:(NSInteger)row;

@end
