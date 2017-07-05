//
//  TJZCodeWrongViewController.m
//  JieZhiReader
//
//  Created by tu on 2017/6/29.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZCodeWrongViewController.h"

@interface TJZCodeWrongViewController ()

@end

@implementation TJZCodeWrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二维码扫描";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toScanClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
