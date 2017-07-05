//
//  TJZBookHeaderTableViewCell.m
//  JieZhiReader
//
//  Created by tjut on 17/6/28.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookHeaderTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface TJZBookHeaderTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisher;
@property (weak, nonatomic) IBOutlet UILabel *IBSN;
@property (weak, nonatomic) IBOutlet UILabel *publishTIme;

@end
@implementation TJZBookHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)addCellDataWithModel:(TJZBookModel *)model{
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.ImageURL] placeholderImage:nil];
    _titleLabel.text = model.Title;
    _authorLabel.text = model.Author;
    _publisher.text = model.Publisher;
    _IBSN.text = model.ISBN;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
