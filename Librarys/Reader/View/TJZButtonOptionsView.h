//
//  TJZButtonOptionsView.h
//  JieZhiReader
//
//  Created by tu on 2017/6/30.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol redSetDelegate <NSObject>

-(void)redSetting;
-(void)directory;
-(void)changeColor;

@end


@interface TJZButtonOptionsView : UIView

+ (instancetype)loadOptionView;

@property (nonatomic,weak) id<redSetDelegate>delegate;

@end
