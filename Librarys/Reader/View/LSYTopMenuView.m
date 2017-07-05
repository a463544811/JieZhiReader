//
//  LSYTopMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYTopMenuView.h"
#import "LSYMenuView.h"
@interface LSYTopMenuView ()
@property (nonatomic,strong) UIButton *back;
@property (nonatomic,strong) UILabel * titleLabel;
//@property (nonatomic,strong) UIButton *more;
@end
@implementation LSYTopMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.back];
    [self addSubview:self.titleLabel];
//    [self addSubview:self.more];
}
//-(void)setState:(BOOL)state
//{
//    _state = state;
//    if (state) {
//        [_more setImage:[[UIImage imageNamed:@"sale_discount_yellow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//        return;
//    }
//    [_more setImage:[[UIImage imageNamed:@"sale_discount_yellow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
//}
-(UIButton *)back
{
    if (!_back) {
        _back = [LSYReadUtilites commonButtonSEL:@selector(backView) target:self];
        [_back setImage:[UIImage imageNamed:@"tab_back1"] forState:UIControlStateNormal];
    }
    return _back;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

//-(UIButton *)more
//{
//    if (!_more) {
//        _more = [LSYReadUtilites commonButtonSEL:@selector(moreOption) target:self];
//        [_more setImage:[[UIImage imageNamed:@"sale_discount_yellow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
//        [_more setImageEdgeInsets:UIEdgeInsetsMake(7.5, 12.5, 7.5, 12.5)];
//    }
//    return _more;
//}
//-(void)moreOption
//{
//    if ([self.delegate respondsToSelector:@selector(menuViewMark:)]) {
//        [self.delegate menuViewMark:self];
//    }
//}
-(void)backView
{
    [[LSYReadUtilites getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _back.frame = CGRectMake(0, 24, 40, 40);
    //_more.frame = CGRectMake(ViewSize(self).width-50, 24, 40, 40);
    _titleLabel.text = @"择天记";
    _titleLabel.frame = CGRectMake(0, 0, 250, 40);
    _titleLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + 10);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
