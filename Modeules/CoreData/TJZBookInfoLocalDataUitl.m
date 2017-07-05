//
//  TJZBookInfoLocalDataUitl.m
//  JieZhiReader
//
//  Created by tjut on 17/6/29.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookInfoLocalDataUitl.h"
#import "CoreDataUtil.h"

#import "TJZBookTable.h"
@implementation TJZBookInfoLocalDataUitl

static NSString *const kTableName = @"TJZBookTable";

+ (void)insertBook:(TJZBookModel *)book{
    NSManagedObjectContext *context = [CoreDataUtil getCoreDataContext];

    TJZBookTable *info = [NSEntityDescription insertNewObjectForEntityForName:kTableName inManagedObjectContext:context];
    info.name = book.Title;
    info.bookPath = book.BookURL;
    info.imageUrl = book.ImageURL;
    NSError *error;
           if (![context save:&error]) {
                NSLog(@"不能保存：%@", [error localizedDescription]);
            }


}

+ (NSMutableArray *)selectAllData{
    NSManagedObjectContext *context = [CoreDataUtil getCoreDataContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kTableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultBooks = [NSMutableArray array];
    for (TJZBookTable *info in fetchedObjects) {
        TJZBookModel *book = [TJZBookModel new];
        book.ImageURL = info.imageUrl;
        book.BookURL = info.bookPath;
        book.Title = info.name;
        //book.readPercent = info.readPercent;
        [resultBooks addObject:book];
    }
    return resultBooks;

}

+ (void)deleteBooks{
    
    NSManagedObjectContext *context = [CoreDataUtil getCoreDataContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kTableName];
    
    NSArray *books = [context executeFetchRequest:request error:nil];
    
       // 3.保存
    [context save:nil];

}
@end
