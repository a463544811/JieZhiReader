//
//  TJZBookModel.h
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
@interface TJZBookModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *ImageURL;
@property (nonatomic,strong) NSString *BookURL;
@property (nonatomic,strong) NSString *Info;
@property (nonatomic,strong) NSString *Author;
@property (nonatomic,strong) NSString *Publisher;
@property (nonatomic,strong) NSString *Title;
@property (nonatomic,strong) NSString *ISBN;
@property (nonatomic,assign) NSInteger readPercent;
@end
