//
//  TJZAlertViewController.h
//  MianPin
//
//  Created by carlxu on 16/10/26.
//  Copyright © 2016年 carlxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJZAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(TJZAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;

@end

@interface TJZAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<TJZAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)addAction:(TJZAlertAction *)action;

@end
