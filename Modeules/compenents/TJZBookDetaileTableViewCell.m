//
//  TJZBookDetaileTableViewCell.m
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookDetaileTableViewCell.h"
#import "UIColor+TJZExt.h"
@implementation TJZBookDetaileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backButton.layer.borderColor = [[UIColor colorFromHexString:@"#65c9a1"]CGColor];
    _backButton.layer.borderWidth = 1;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
