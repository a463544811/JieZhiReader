//
//  CoreDataUtil.h
//  MianLiao
//
//  Created by nick on 15-5-6.
//  Copyright (c) 2015年 Tjut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataUtil : NSObject

+ (NSManagedObjectContext *)getCoreDataContext;

@end
