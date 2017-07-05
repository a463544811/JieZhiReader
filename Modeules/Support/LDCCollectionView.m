//
//  LDCCollectionView.m
//  MIMEChat3
//
//  Created by tjut on 16/7/27.
//
//

#import "LDCCollectionView.h"
#import "MJRefresh.h"
#import "TJZGIFRefreshHeader.h"
#import "UIColor+TJZExt.h"

@interface LDCCollectionView()<LDCCollectionDelegate>
@property (weak, nonatomic) TJZGIFRefreshHeader *refreshControl;

@property (nonatomic) BOOL loadMoreIsShown;
@property (weak, nonatomic) UIActivityIndicatorView *loadMoreIndicator;

// add
@property (nonatomic, strong) NSArray *gifImageList;
@end
static CGFloat const kLoadMoreSpinnerSize = 40;
@implementation LDCCollectionView

- (void)awakeFromNib {
    //self.backgroundColor = [UIColor themeBackgroundColor];
    [self dealWithNightModel];
    //[self setup];
}

- (void)setup {
    [self MJRefreshConfigure];
    [self defaultPublicAPIs];
    //[self pullDownRefreshHeader];
}

- (void)dealWithNightModel {
    
}

- (void)pullDownRefreshHeader {
    [self.mj_header beginRefreshing];
}

- (void)MJRefreshConfigure {
    self.mj_header = [TJZGIFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)]; //footer;
}

- (void)defaultPublicAPIs {
    self.showRefreshDetail = NO;
    self.automaticallyLoadMore = NO;
}

#pragma mark - Public Properties
- (void)setShowRefreshDetail:(BOOL)showRefreshDetail {
    _showRefreshDetail = showRefreshDetail;
    
    ((MJRefreshGifHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.showRefreshDetail;
    ((MJRefreshGifHeader *)self.mj_header).stateLabel.hidden = !self.showRefreshDetail;
    ((MJRefreshBackGifFooter *)self.mj_footer).stateLabel.hidden = !self.showRefreshDetail;
}

- (void)setAutomaticallyLoadMore:(BOOL)automaticallyLoadMore {
    _automaticallyLoadMore = automaticallyLoadMore;
    
    if (_automaticallyLoadMore) {
        self.mj_footer = nil;
        MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreDataSelector)];
        autofooter.triggerAutomaticallyRefreshPercent = 1;
        self.mj_footer = autofooter;
    }
}

- (void)setHasMore:(BOOL)hasMore {
    _hasMore = hasMore;
    if (!_hasMore) {
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.mj_footer resetNoMoreData];
    }
}

#pragma mark--
#pragma mark - loading methods
- (void)loadNewDataSelector {
    if ([self.ldcDelegate respondsToSelector:@selector(ldcRefresh)]) {
        // 默认刷一次
        //[self pullDownRefreshHeader];
        [self.ldcDelegate ldcRefresh];
        [self headerEnding];
    }
}

- (void)headerEnding {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
        [self.mj_header endRefreshing];
    });
}

- (void)loadMoreDataSelector {
    if (_automaticallyLoadMore) {
        dispatch_queue_t queue = dispatch_queue_create("refreshAutoFooter", NULL);
        dispatch_async(queue, ^{
            [self.ldcDelegate ldcLoadMore];
            [self footerEnding];
        });
        
        return;
    } else if (self.loadMoreIsShown) {
        
    }else {
        [self.ldcDelegate ldcLoadMore];
        self.loadMoreIsShown = YES;
    }
    
    [self performSelector:@selector(footerEnding) withObject:nil afterDelay:1.0];
    //[self footerEnding];
}

- (void)footerEnding {
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self reloadData];
        [self.mj_footer endRefreshing];
        self.loadMoreIsShown = NO;
    });
}
//-------------------------------------------

- (void)enableRefreshing {
    [self setup];
}

- (void)endLoadingContent {
    //[self.mj_footer endRefreshing];
    //[self.mj_header endRefreshing];
    //[self footerEnding];
}

- (void)endRefreshing {
    //[self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.2];
    [self.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.2];
}

- (void)setHideBottomRefresh:(BOOL)hideBottomRefresh {
    _hideBottomRefresh = hideBottomRefresh;
    if (hideBottomRefresh) {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
}


@end
