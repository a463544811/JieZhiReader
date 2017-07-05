//
//  TDLBaseViewController.m
//  DigitalLibrary
//
//  Created by carlxu on 2017/4/10.
//  Copyright © 2017年 carlxu. All rights reserved.
//

#import "TJZBaseViewController.h"
#import "UIColor+TJZExt.h"

@interface TJZBaseViewController ()

@end

@implementation TJZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#f0f1f2"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UITextField appearance] setTintColor:[UIColor colorFromHexString:@"#6faaf4"]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:@"#65c9a1"]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorFromHexString:@"#ffffff"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#ffffff"]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(popToLastPage)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)popToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

@end
