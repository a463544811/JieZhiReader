//
//  TJZAllStyleReadViewController.h
//  JieZhiReader
//
//  Created by tjut on 17/6/26.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBaseViewController.h"
typedef NS_ENUM(NSInteger,stateType){
    stateTypeLatestRead,
    stateTypeAlreadyRead,
    stateTypeNoneRead,
    stateTypeAllRead
};
@interface TJZAllStyleReadViewController : TJZBaseViewController
@property (nonatomic,assign) NSInteger type;

- (void)edit:(BOOL)isDelete;

@end
