//
//  TJZMainPageCollectionViewCell.h
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJZBookModel.h"
@interface TJZMainPageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *readPercent;
@property (weak, nonatomic) IBOutlet UILabel *name;

- (void)showCellDataWithModel:(TJZBookModel *)bookModel isEdict:(BOOL)isEdict;

@end
