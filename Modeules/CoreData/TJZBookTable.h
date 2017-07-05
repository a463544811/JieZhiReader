//
//  TJZBookTable.h
//  JieZhiReader
//
//  Created by tjut on 17/6/29.
//  Copyright © 2017年 long. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface TJZBookTable : NSManagedObject
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *bookPath;
@property (nonatomic) NSInteger readPercent;
@property (nonatomic) NSInteger readTime;
@end
