//
//  LDCTableView.h
//  supertable
//
//  Created by Edward Gu on 15/3/16.
//  Copyright (c) 2015年 Tjut Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用说明：
 *  需要下拉刷新的 tableview 成为ldcDelegate的代理
 *  enableRefreshing : 初始化UI
 *  实现 ldcRefresh,ldcLoadMore
 *  若第一次加载(eg.viewDidLoad)需要下拉动画调用 pullDownRefreshHeader 即可，不需要则直接调用 ldcRefresh
 */
@class LDCTableView;

@protocol LDCTableViewDelegate <NSObject>

@optional
- (void)ldcRefresh;
- (void)ldcLoadMore;
/**
 *  以下两个代理过期 －－－ 请不要使用 ！！
 */
- (void)ldcTableViewRefresh:(UITableView *)tableView;
- (void)ldcTableViewLoadMore:(UITableView *)tableView;

@end

@interface LDCTableView : UITableView

@property (weak, nonatomic) IBOutlet id<LDCTableViewDelegate> ldcDelegate;

// set YES to enable loadmore when scroll to bottom.
@property (nonatomic) BOOL hasMore;

// set up refresh control
- (void)enableRefreshing;

// call this on ViewWillAppear. it's a bug of UIRefreshControl.
- (void)endRefreshing;

// end refresh or loadmore
- (void)endLoadingContent;

/**
 *  add by 12 - 11
 */
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
