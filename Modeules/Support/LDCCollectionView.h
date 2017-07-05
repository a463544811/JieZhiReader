//
//  LDCCollectionView.h
//  MIMEChat3
//
//  Created by tjut on 16/7/27.
//
//

#import <UIKit/UIKit.h>
@class LDCCollectionView ;
@protocol LDCCollectionDelegate <NSObject>
@optional
- (void)ldcRefresh;
- (void)ldcLoadMore;
@end
@interface LDCCollectionView : UICollectionView
@property (weak, nonatomic) id<LDCCollectionDelegate> ldcDelegate;
// set YES to enable loadmore when scroll to bottom.
@property (nonatomic) BOOL hasMore;

// set up refresh control
- (void)enableRefreshing;

// call this on ViewWillAppear. it's a bug of UIRefreshControl.
- (void)endRefreshing;

// end refresh or loadmore
- (void)endLoadingContent;

// Default is `NO` -> Only GIF images , Show words when it become `YES`
@property (nonatomic) BOOL showRefreshDetail;

// Default is `NO` -> Manually Loading . Automatically load when it becomes `YES`
@property (nonatomic) BOOL automaticallyLoadMore;

@property (nonatomic) BOOL hideBottomRefresh;

/**
 *  需要下拉动画调用此方法 替换 初始化时的获取数据方法
 */
- (void)pullDownRefreshHeader;

@end
