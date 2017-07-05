//
//  TJZButtonOptionsView.m
//  JieZhiReader
//
//  Created by tu on 2017/6/30.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZButtonOptionsView.h"
#import "UIColor+TJZExt.h"

@interface TJZButtonOptionsView()


@end

@implementation TJZButtonOptionsView

+ (instancetype)loadOptionView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TJZButtonOptionsView" owner:nil options:nil] lastObject];
}

- (IBAction)settingClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(redSetting)]) {
        [_delegate redSetting];
    }
}
- (IBAction)nightClick:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:[UIColor colorWithHex:@"#262626"]];
    if ([_delegate respondsToSelector:@selector(changeColor)]) {
        [_delegate changeColor];
    }
}

- (IBAction)directoryClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(directory)]) {
        [_delegate directory];
    }
}
@end
