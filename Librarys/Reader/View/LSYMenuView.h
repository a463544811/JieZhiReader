//
//  LSYMenuView.h
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYRecordModel.h"
#import "LSYTopMenuView.h"

@class LSYMenuView;
@class LSYBottomMenuView;
@class TJZButtonOptionsView;
@protocol LSYMenuViewDelegate <NSObject>
@optional
-(void)menuViewDidHidden:(LSYMenuView *)menu;
-(void)menuViewDidAppear:(LSYMenuView *)menu;
-(void)menuViewInvokeCatalog:(LSYBottomMenuView *)bottomMenu;
-(void)menuViewJumpChapter:(NSUInteger)chapter page:(NSUInteger)page;
-(void)menuViewFontSize:(LSYBottomMenuView *)bottomMenu;
-(void)menuViewMark:(LSYTopMenuView *)topMenu;
-(void)menuViewDirectory;
@end
@interface LSYMenuView : UIView
@property (nonatomic,weak) id<LSYMenuViewDelegate> delegate;
@property (nonatomic,strong) LSYRecordModel *recordModel;
@property (nonatomic,strong) LSYTopMenuView *topView;
@property (nonatomic,strong) LSYBottomMenuView *bottomView;
@property (nonatomic,strong) TJZButtonOptionsView * optionView;


-(void)showAnimation:(BOOL)animation;
-(void)hiddenAnimation:(BOOL)animation;
@end
