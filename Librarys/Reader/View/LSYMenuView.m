//
//  LSYMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYMenuView.h"
#import "LSYTopMenuView.h"
#import "LSYBottomMenuView.h"
#import "TJZButtonOptionsView.h"
#import "UIColor+TJZExt.h"
#import "TJZUtil.h"

#define AnimationDelay 0.3f
#define TopViewHeight 64.0f
#define BottomViewHeight 150.0f
#define redViewHeight 70.0f
@interface LSYMenuView ()<LSYMenuViewDelegate,redSetDelegate>
{
    BOOL _isSet;
}

@end
@implementation LSYMenuView
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
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.optionView];
    
    if ([TJZUtil viewColor]) {
        _topView.backgroundColor = [UIColor colorWithHex:[TJZUtil viewColor]];
        _optionView.backgroundColor = [UIColor colorWithHex:[TJZUtil viewColor]];
        _bottomView.backgroundColor = [UIColor colorWithHex:[TJZUtil viewColor]];
    }
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewColor:) name:@"changeViewColor" object:nil];
}

-(void)changeViewColor:(NSNotification *)no{
    _topView.backgroundColor = no.object;
    _optionView.backgroundColor = no.object;
    _bottomView.backgroundColor = no.object;
}

-(TJZButtonOptionsView *)optionView{
    if (!_optionView) {
        _optionView = [TJZButtonOptionsView loadOptionView];
        _optionView.delegate = self;
    }
    return _optionView;
}

-(LSYTopMenuView *)topView
{
    if (!_topView) {
        _topView = [[LSYTopMenuView alloc] init];
        _topView.delegate = self;
    }
    return _topView;
}
-(LSYBottomMenuView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[LSYBottomMenuView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
-(void)setRecordModel:(LSYRecordModel *)recordModel
{
    _recordModel = recordModel;
    _bottomView.readModel = recordModel;
}

-(void)redSetting{
    _isSet = YES;
    if ([TJZUtil textViewColor]) {
        self.bottomView.increaseFont.backgroundColor = [UIColor colorWithHex:[TJZUtil textViewColor]];
        self.bottomView.decreaseFont.backgroundColor = [UIColor colorWithHex:[TJZUtil textViewColor]];
    }else{
        self.bottomView.increaseFont.backgroundColor = [UIColor colorWithHex:@"#ebf0f2"];
        self.bottomView.decreaseFont.backgroundColor = [UIColor colorWithHex:@"#ebf0f2"];
    }
    
    if ([[TJZUtil textViewColor] isEqualToString:@"#262626"]) {
        [self.bottomView.increaseFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bottomView.decreaseFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.bottomView.increaseFont setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.bottomView.decreaseFont setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [self addSubview:self.bottomView];
    [UIView animateWithDuration:YES?AnimationDelay:0 animations:^{
        _bottomView.frame = CGRectMake(0, ViewSize(self).height-BottomViewHeight, ViewSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
        [self.delegate menuViewDidAppear:self];
    }
}

-(void)directory{
//    if ([_delegate respondsToSelector:@selector(menuViewDirectory)]) {
//        [_delegate menuViewDirectory];
//    }
    
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:nil];
    }
}

-(void)changeColor{
    if ([[TJZUtil viewColor] isEqualToString:@"#ffffff"]) {
        _topView.backgroundColor = [UIColor colorWithHex:@"#4d4d4d"];
        _optionView.backgroundColor = [UIColor colorWithHex:@"#4d4d4d"];
        _bottomView.backgroundColor = [UIColor colorWithHex:@"#4d4d4d"];
        [TJZUtil didViewColor:@"#4d4d4d"];
        [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#262626"];
        [LSYReadConfig shareInstance].fontColor = [UIColor whiteColor];
        if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
            [self.delegate menuViewFontSize:nil];
        }
    }else{
        _topView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
        _optionView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
        _bottomView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
        [TJZUtil didViewColor:@"#ffffff"];
        [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#ebf0f2"];
        [LSYReadConfig shareInstance].fontColor = [UIColor blackColor];
        if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
            [self.delegate menuViewFontSize:nil];
        }
    }
}

#pragma mark - LSYMenuViewDelegate

-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:bottomMenu];
    }
}
-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page
{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
        [self.delegate menuViewJumpChapter:chapter page:page];
    }
}
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:bottomMenu];
    }
}
-(void)menuViewMark:(LSYTopMenuView *)topMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewMark:)]) {
        [self.delegate menuViewMark:topMenu];
    }
}
#pragma mark -
-(void)hiddenSelf
{
    [self hiddenAnimation:YES];
}
-(void)showAnimation:(BOOL)animation
{
    self.hidden = NO;
//    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
//        _topView.frame = CGRectMake(0, 0, ViewSize(self).width, TopViewHeight);
//        _bottomView.frame = CGRectMake(0, ViewSize(self).height-BottomViewHeight, ViewSize(self).width,BottomViewHeight);
//    } completion:^(BOOL finished) {
//        
//    }];
//    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
//        [self.delegate menuViewDidAppear:self];
//    }
    
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, 0, ViewSize(self).width, TopViewHeight);
        _optionView.frame = CGRectMake(0, ViewSize(self).height-redViewHeight, ViewSize(self).width,redViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
        [self.delegate menuViewDidAppear:self];
    }
}
-(void)hiddenAnimation:(BOOL)animation
{
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width, TopViewHeight);
         _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
//    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
//        _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width, TopViewHeight);
//        _optionView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,redViewHeight);
//        _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
//    } completion:^(BOOL finished) {
//        self.hidden = YES;
//        [_bottomView removeFromSuperview];
//    }];
    
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_isSet) {
        _optionView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,redViewHeight);
    }else{
        _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width,TopViewHeight);
        _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
        _optionView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,redViewHeight);
    }
}
@end
