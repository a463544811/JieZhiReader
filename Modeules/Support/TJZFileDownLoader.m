//
//  TDLFileDownLoader.m
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/20.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#import "TJZFileDownLoader.h"

@implementation TJZFileDownLoader

+ (NSString *)keyForUrl:(NSString *)fileUrl {
    NSString *fileName = [fileUrl lastPathComponent];
    return [NSString stringWithFormat:@"%ld_%@", fileUrl.hash, fileName];
}

+ (NSString *)filePathForUrl:(NSString *)fileUrl {
    return [[self documentsDirectory] stringByAppendingPathComponent:[self keyForUrl:fileUrl]];
}

+ (NSString *)filePathForFileName:(NSString *)fileName{

   return [[self documentsDirectory] stringByAppendingPathComponent:fileName];
}
+ (BOOL)fileExistsForUrl:(NSString *)fileUrl {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self filePathForUrl:fileUrl]];
}

+ (BOOL)fileExistsForFileName:(NSString *)fileName{
    NSString *filePath = [[self documentsDirectory]stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager]fileExistsAtPath:filePath];
}

+ (NSString *)folderNameForZipFile:(NSString *)filePath {
    return [NSString stringWithFormat:@"%@_folder", filePath];
}

+ (void)downloadFile:(NSString *)fileUrl withName:(NSString *)fileName completed:(FileDownloadCallback)callback {
        NSURL *url = [NSURL URLWithString:fileUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        NSString *filePath = [self filePathForUrl:fileUrl];
        BOOL successsful = urlData != nil;
        if (successsful) {
            
                [urlData writeToFile:filePath atomically:YES];
            
        }
        callback(successsful, filePath);
}

+ (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}



@end
