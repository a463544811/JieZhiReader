//
//  LSYBottomMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYBottomMenuView.h"
#import "LSYMenuView.h"
#import "UIColor+TJZExt.h"
#import "Masonry.h"
#import "TJZUtil.h"

@interface LSYBottomMenuView ()<changeColorDelegate>
@property (nonatomic,strong) LSYReadProgressView *progressView;
@property (nonatomic,strong) LSYThemeView *themeView;
@property (nonatomic,strong) UIButton *minSpacing;
@property (nonatomic,strong) UIButton *mediuSpacing;
@property (nonatomic,strong) UIButton *maxSpacing;
@property (nonatomic,strong) UIButton *catalog;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIButton *lastChapter;
@property (nonatomic,strong) UIButton *nextChapter;
@property (nonatomic,strong) UILabel *fontLabel;
@end
@implementation LSYBottomMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self setBackgroundColor:[UIColor whiteColor]];
    //[self addSubview:self.slider];
    //[self addSubview:self.catalog];
    [self addSubview:self.progressView];
    //[self addSubview:self.lastChapter];
    //[self addSubview:self.nextChapter];
    [self addSubview:self.increaseFont];
    [self addSubview:self.decreaseFont];
    [self addSubview:self.fontLabel];
    [self addSubview:self.themeView];
    [self addObserver:self forKeyPath:@"readModel.chapter" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"readModel.page" options:NSKeyValueObservingOptionNew context:NULL];
    
//    _increaseFont.backgroundColor = [UIColor colorWithHex:[TJZUtil textViewColor]];
//    _decreaseFont.backgroundColor = [UIColor colorWithHex:[TJZUtil textViewColor]];
//    if ([[TJZUtil textViewColor] isEqualToString:@"#262626"]) {
//        [_increaseFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_decreaseFont setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }else{
//        [_increaseFont setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_decreaseFont setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
    
    
    [[LSYReadConfig shareInstance] addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
}

-(UIButton *)catalog
{
    if (!_catalog) {
        _catalog = [LSYReadUtilites commonButtonSEL:@selector(showCatalog) target:self];
        [_catalog setImage:[UIImage imageNamed:@"reader_cover"] forState:UIControlStateNormal];
    }
    return _catalog;
}

-(LSYReadProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[LSYReadProgressView alloc] init];
        _progressView.hidden = YES;
        
    }
    return _progressView;
}

-(UISlider *)slider
{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
        _slider.minimumTrackTintColor = RGB(227, 0, 0);
        _slider.maximumTrackTintColor = [UIColor whiteColor];
        [_slider setThumbImage:[self thumbImage] forState:UIControlStateNormal];
        [_slider setThumbImage:[self thumbImage] forState:UIControlStateHighlighted];
        [_slider addTarget:self action:@selector(changeMsg:) forControlEvents:UIControlEventValueChanged];
        [_slider addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
    }
    return _slider;
}
-(UIButton *)nextChapter
{
    if (!_nextChapter) {
        _nextChapter = [LSYReadUtilites commonButtonSEL:@selector(jumpChapter:) target:self];
        [_nextChapter setTitle:@"下一章" forState:UIControlStateNormal];
    }
    return _nextChapter;
}
-(UIButton *)lastChapter
{
    if (!_lastChapter) {
        _lastChapter = [LSYReadUtilites commonButtonSEL:@selector(jumpChapter:) target:self];
        [_lastChapter setTitle:@"上一章" forState:UIControlStateNormal];
    }
    return _lastChapter;
}
-(UIButton *)increaseFont
{
    if (!_increaseFont) {
        _increaseFont = [LSYReadUtilites commonButtonSEL:@selector(changeFont:) target:self];
        [_increaseFont setTitle:@"A+" forState:UIControlStateNormal];
        [_increaseFont.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _increaseFont.backgroundColor = [UIColor colorWithHex:@"#ebf0f2"];
        [_increaseFont setTitleColor:[UIColor colorWithHex:@"#404040"] forState:UIControlStateNormal];
    }
    return _increaseFont;
}
-(UIButton *)decreaseFont
{
    if (!_decreaseFont) {
        _decreaseFont = [LSYReadUtilites commonButtonSEL:@selector(changeFont:) target:self];
        [_decreaseFont setTitle:@"A-" forState:UIControlStateNormal];
        [_decreaseFont.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _decreaseFont.backgroundColor = [UIColor colorWithHex:@"#ebf0f2"];
        [_decreaseFont setTitleColor:[UIColor colorWithHex:@"#404040"] forState:UIControlStateNormal];
    }
    return _decreaseFont;
}

-(void)changeViewColors:(UIColor *)color withTextColor:(UIColor *)textColor{
    _increaseFont.backgroundColor = color;
    _decreaseFont.backgroundColor = color;
    [_increaseFont setTitleColor:textColor forState:UIControlStateNormal];
    [_decreaseFont setTitleColor:textColor forState:UIControlStateNormal];
}

-(UILabel *)fontLabel
{
    if (!_fontLabel) {
        _fontLabel = [[UILabel alloc] init];
        _fontLabel.font = [UIFont systemFontOfSize:14];
        _fontLabel.textColor = [UIColor redColor];
        _fontLabel.textAlignment = NSTextAlignmentCenter;
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[LSYReadConfig shareInstance].fontSize];
    }
    return _fontLabel;
}

-(LSYThemeView *)themeView
{
    if (!_themeView) {
        _themeView = [[LSYThemeView alloc] init];
        _themeView.colorDelegate = self;
    }
    return _themeView;
}
#pragma mark - Button Click
-(void)jumpChapter:(UIButton *)sender
{
    if (sender == _nextChapter) {
        if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
            [self.delegate menuViewJumpChapter:(_readModel.chapter == _readModel.chapterCount-1)?_readModel.chapter:_readModel.chapter+1 page:0];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
            [self.delegate menuViewJumpChapter:_readModel.chapter?_readModel.chapter-1:0 page:0];
        }
        
    }
}

-(void)changeTextColor{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:self];
    }
}

-(void)changeFont:(UIButton *)sender
{

    if (sender == _increaseFont) {

        if (floor([LSYReadConfig shareInstance].fontSize) == floor(MaxFontSize)) {
            return;
        }
        [LSYReadConfig shareInstance].fontSize++;
    }
    else{
        if (floor([LSYReadConfig shareInstance].fontSize) == floor(MinFontSize)){
            return;
        }
        [LSYReadConfig shareInstance].fontSize--;
    }
    
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:self];
    }
}
#pragma mark showMsg

-(void)changeMsg:(UISlider *)sender
{
    NSUInteger page =ceil((_readModel.chapterModel.pageCount-1)*sender.value/100.00);
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:page:)]) {
        [self.delegate menuViewJumpChapter:_readModel.chapter page:page];
    }
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"readModel.chapter"] || [keyPath isEqualToString:@"readModel.page"]) {
        _slider.value = _readModel.page/((float)(_readModel.chapterModel.pageCount-1))*100;
        [_progressView title:_readModel.chapterModel.title progress:[NSString stringWithFormat:@"%.1f%%",_slider.value]];
    }
    else if ([keyPath isEqualToString:@"fontSize"]){
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[LSYReadConfig shareInstance].fontSize];
    }
    else{
        if (_slider.state == UIControlStateNormal) {
            _progressView.hidden = YES;
        }
        else if(_slider.state == UIControlStateHighlighted){
            _progressView.hidden = NO;
        }
    }
    
}
-(UIImage *)thumbImage
{
    CGRect rect = CGRectMake(0, 0, 15,15);
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    [path addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:7.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    {
        [[UIColor whiteColor] setFill];
        [path fill];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return image;
}
-(void)showCatalog
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    _slider.frame = CGRectMake(50, 20, ViewSize(self).width-100, 30);
//    _lastChapter.frame = CGRectMake(5, 20, 40, 30);
//    _nextChapter.frame = CGRectMake(DistanceFromLeftGuiden(_slider)+5, 20, 40, 30);
    
//    _decreaseFont.frame = CGRectMake(15, 15, (ViewSize(self).width-20)/3, 40);
//    
//    _fontLabel.frame = CGRectMake(DistanceFromLeftGuiden(_decreaseFont), self.bounds.size.width/2, 30,  30);
//    
//    _increaseFont.frame = CGRectMake(DistanceFromLeftGuiden(_fontLabel), 15,  (ViewSize(self).width-20)/3, 40);
    
    int padding1 = 10;
    [_decreaseFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@15);
        make.left.equalTo(self.mas_left).with.offset(padding1);
        make.right.equalTo(_increaseFont.mas_left).with.offset(-40);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_increaseFont);
    }];
    [_increaseFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@15);
        make.left.equalTo(_decreaseFont.mas_right).with.offset(40);
        make.right.equalTo(self.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(@40);
        make.width.equalTo(_decreaseFont);
    }];
    
    
    _themeView.frame = CGRectMake(0, DistanceFromTopGuiden(_increaseFont)+20, ViewSize(self).width, 80);
//    _catalog.frame = CGRectMake(10, DistanceFromTopGuiden(_themeView), 30, 30);
//    _progressView.frame = CGRectMake(60, -60, ViewSize(self).width-120, 50);
    
}
-(void)dealloc
{
//    [_slider removeObserver:self forKeyPath:@"highlighted"];
//    [self removeObserver:self forKeyPath:@"readModel.chapter"];
//    [self removeObserver:self forKeyPath:@"readModel.page"];
//    [[LSYReadConfig shareInstance] removeObserver:self forKeyPath:@"fontSize"];
}
@end
@interface LSYThemeView ()
@property (nonatomic,strong) UIView *theme1;
@property (nonatomic,strong) UIView *theme2;
@property (nonatomic,strong) UIView *theme3;
@property (nonatomic,strong) UIView *theme4;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@end
@implementation LSYThemeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.theme1];
    [self addSubview:self.theme2];
    [self addSubview:self.theme3];
    [self addSubview:self.theme4];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.label3];
    [self addSubview:self.label4];
}

-(UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"默认";
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.textColor = [UIColor colorWithHex:@"#999999"];
    }
    return _label1;
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text = @"羊皮纸";
        _label2.font = [UIFont systemFontOfSize:14];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.textColor = [UIColor colorWithHex:@"#999999"];
    }
    return _label2;
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.text = @"护眼绿";
        _label3.font = [UIFont systemFontOfSize:14];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.textColor = [UIColor colorWithHex:@"#999999"];
    }
    return _label3;
}

-(UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.text = @"夜间";
        _label4.font = [UIFont systemFontOfSize:14];
        _label4.textAlignment = NSTextAlignmentCenter;
        _label4.textColor = [UIColor colorWithHex:@"#999999"];
    }
    return _label4;
}

-(UIView *)theme1
{
    if (!_theme1) {
        _theme1 = [[UIView alloc] init];
        _theme1.tag = 1;
        _theme1.backgroundColor = [UIColor colorWithHex:@"#ebf0f2"];
        [_theme1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
        _theme1.layer.cornerRadius = 20;
        _theme1.layer.masksToBounds = YES;
    }
    return _theme1;
}

-(UIView *)theme2
{
    if (!_theme2) {
        _theme2 = [[UIView alloc] init];
        _theme2.tag = 2;
        _theme2.backgroundColor = [UIColor colorWithHex:@"#e3ddcb"];
        [_theme2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
        _theme2.layer.cornerRadius = 20;
        _theme2.layer.masksToBounds = YES;
    }
    return _theme2;
}

-(UIView *)theme3
{
    if (!_theme3) {
        _theme3 = [[UIView alloc] init];
        _theme3.tag = 3;
        _theme3.backgroundColor = [UIColor colorWithHex:@"#cce5d4"];
        [_theme3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
        _theme3.layer.cornerRadius = 20;
        _theme3.layer.masksToBounds = YES;
    }
    return _theme3;
}

-(UIView *)theme4
{
    if (!_theme4) {
        _theme4 = [[UIView alloc] init];
        _theme4.tag = 4;
        _theme4.backgroundColor = [UIColor colorWithHex:@"#262626"];
        [_theme4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)]];
        _theme4.layer.cornerRadius = 20;
        _theme4.layer.masksToBounds = YES;
    }
    return _theme4;
}

-(void)changeView:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeViewColor" object:[UIColor colorWithHex:@"#4d4d4d"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#262626"];
    if ([_colorDelegate respondsToSelector:@selector(changeViewColors:withTextColor:)]) {
        [_colorDelegate changeViewColors:[UIColor colorWithHex:@"#262626"] withTextColor:[UIColor whiteColor]];
    }
    [TJZUtil didViewColor:@"#4d4d4d"];
    
    [LSYReadConfig shareInstance].fontColor = [UIColor whiteColor];
    if ([_colorDelegate respondsToSelector:@selector(changeTextColor)]) {
        [_colorDelegate changeTextColor];
    }
}

-(void)changeTheme:(UITapGestureRecognizer *)tap
{
    UIView *targetview = tap.view;
    if (targetview.tag == 1) {
       [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#ebf0f2"];
        if ([_colorDelegate respondsToSelector:@selector(changeViewColors:withTextColor:)]) {
            [_colorDelegate changeViewColors:[UIColor colorWithHex:@"#ebf0f2"] withTextColor:[UIColor blackColor]];
        }
    }else if (targetview.tag == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#e3ddcb"];
        if ([_colorDelegate respondsToSelector:@selector(changeViewColors:withTextColor:)]) {
            [_colorDelegate changeViewColors:[UIColor colorWithHex:@"#e3ddcb"] withTextColor:[UIColor blackColor]];
        }
    }else if (targetview.tag == 3){
        [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#cce5d4"];
        if ([_colorDelegate respondsToSelector:@selector(changeViewColors:withTextColor:)]) {
            [_colorDelegate changeViewColors:[UIColor colorWithHex:@"#cce5d4"] withTextColor:[UIColor blackColor]];
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:LSYThemeNotification object:@"#262626"];
        if ([_colorDelegate respondsToSelector:@selector(changeViewColors:withTextColor:)]) {
            [_colorDelegate changeViewColors:[UIColor colorWithHex:@"#262626"] withTextColor:[UIColor blackColor]];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeViewColor" object:[UIColor colorWithHex:@"#ffffff"]];
    [TJZUtil didViewColor:@"#ffffff"];
    
    [LSYReadConfig shareInstance].fontColor = [UIColor blackColor];
    if ([_colorDelegate respondsToSelector:@selector(changeTextColor)]) {
        [_colorDelegate changeTextColor];
    }
    
}
-(void)layoutSubviews
{
    CGFloat spacing = (ViewSize(self).width-40*4)/5;
    _theme1.frame = CGRectMake(spacing, 0, 40, 40);
    _theme2.frame = CGRectMake(DistanceFromLeftGuiden(_theme1)+spacing, 0, 40, 40);
    _theme3.frame = CGRectMake(DistanceFromLeftGuiden(_theme2)+spacing, 0, 40, 40);
    _theme4.frame = CGRectMake(DistanceFromLeftGuiden(_theme3)+spacing, 0, 40, 40);
    
    CGFloat spacing1 = (ViewSize(self).width-50*4)/5;
    _label1.frame = CGRectMake(spacing1, 45, 50, 25);
    _label2.frame = CGRectMake(DistanceFromLeftGuiden(_label1)+spacing1, 45, 50, 25);
    _label3.frame = CGRectMake(DistanceFromLeftGuiden(_label2)+spacing1, 45, 50, 25);
    _label4.frame = CGRectMake(DistanceFromLeftGuiden(_label3)+spacing1, 45, 50, 25);
}
@end
@interface LSYReadProgressView ()
@property (nonatomic,strong) UILabel *label;
@end
@implementation LSYReadProgressView
- (instancetype)init
{
    self = [super init];
    if (self) {
         [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        [self addSubview:self.label];
    }
    return self;
}
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:[LSYReadConfig shareInstance].fontSize];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}
-(void)title:(NSString *)title progress:(NSString *)progress
{
    _label.text = [NSString stringWithFormat:@"%@\n%@",title,progress];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.bounds;
}
@end
