//
//  TDLFileDownLoader.h
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/20.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FileDownloadCallback)(BOOL successful, NSString *filePath);

@interface TJZFileDownLoader : NSObject

+ (NSString *)keyForUrl:(NSString *)fileUrl;

+ (NSString *)filePathForUrl:(NSString *)fileUrl;

+ (NSString *)filePathForFileName:(NSString *)fileName;

+ (BOOL)fileExistsForUrl:(NSString *)fileUrl;

+ (BOOL)fileExistsForFileName:(NSString *)fileName;

+ (NSString *)folderNameForZipFile:(NSString *)filePath;

+ (void)downloadFile:(NSString *)fileUrl withName:(NSString *)fileName completed:(FileDownloadCallback)callback;
+ (NSString *)documentsDirectory ;

@end
