//
//  TJZBookHeaderTableViewCell.h
//  JieZhiReader
//
//  Created by tjut on 17/6/28.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJZBookModel.h"
@interface TJZBookHeaderTableViewCell : UITableViewCell
- (void)addCellDataWithModel:(TJZBookModel *)model;
@end
