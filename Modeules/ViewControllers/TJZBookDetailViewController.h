//
//  TJZBookDetailViewController.h
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBaseViewController.h"

@interface TJZBookDetailViewController : TJZBaseViewController
@property (nonatomic,strong) NSString *resultUrl;
- (void)fetchData;
@end
