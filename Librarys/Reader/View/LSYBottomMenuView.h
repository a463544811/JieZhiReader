//
//  LSYBottomMenuView.h
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYRecordModel.h"

@protocol changeColorDelegate <NSObject>

-(void)changeViewColors:(UIColor *)color withTextColor:(UIColor *)textColor;
-(void)changeTextColor;

@end

@protocol LSYMenuViewDelegate;

@interface LSYBottomMenuView : UIView
@property (nonatomic,weak) id<LSYMenuViewDelegate>delegate;
@property (nonatomic,strong) LSYRecordModel *readModel;
@property (nonatomic,strong) UIButton *increaseFont;
@property (nonatomic,strong) UIButton *decreaseFont;

@end

@interface LSYThemeView : UIView

@property (nonatomic,weak) id<changeColorDelegate>colorDelegate;

@end

@interface LSYReadProgressView : UIView
-(void)title:(NSString *)title progress:(NSString *)progress;
@end
