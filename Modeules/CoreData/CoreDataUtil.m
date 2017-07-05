//
//  CoreDataUtil.m
//  MianLiao
//
//  Created by nick on 15-5-6.
//  Copyright (c) 2015年 Tjut Inc. All rights reserved.
//

#import "CoreDataUtil.h"

static NSManagedObjectContext *s_managedObjectcontext = nil;

@implementation CoreDataUtil

+ (NSManagedObjectContext *)getCoreDataContext {
    if (!s_managedObjectcontext) {
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"ml.data"]];

        NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
                                                                                     NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],
                                                                                     NSInferMappingModelAutomaticallyOption, nil];

        NSError *error = nil;

        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:optionsDictionary error:&error];
        if (store == nil) {
            [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
        }

        s_managedObjectcontext = [[NSManagedObjectContext alloc] init];
        s_managedObjectcontext.persistentStoreCoordinator = psc;
    }
    return s_managedObjectcontext;
}

@end
