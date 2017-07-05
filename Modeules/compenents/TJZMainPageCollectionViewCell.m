//
//  TJZMainPageCollectionViewCell.m
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZMainPageCollectionViewCell.h"
#import "TJZBookModel.h"
#import "UIImageView+WebCache.h"
@implementation TJZMainPageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showCellDataWithModel:(TJZBookModel *)bookModel isEdict:(BOOL)isEdict{
    if (isEdict) {
        _chooseImage.hidden = NO;
    }else{
        _chooseImage.hidden = YES;
    }
    [_bookImage sd_setImageWithURL:[NSURL URLWithString:bookModel.ImageURL] placeholderImage:nil];
    _name.text = bookModel.Title;
    
}
@end
