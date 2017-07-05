//
//  ScanSuccessJumpVC.m
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/29.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "ScanSuccessJumpVC.h"
#import "SGWebView.h"
#import "UIColor+TJZExt.h"
@interface ScanSuccessJumpVC () <SGWebViewDelegate>
@property (nonatomic , strong) SGWebView *webView;
@end

@implementation ScanSuccessJumpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationItem];
   
    }

- (void)setupNavigationItem {
    self.title = @"中版数字图书馆";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#404040"]}];
     [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"tab_scan"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_back1"] style:UIBarButtonItemStylePlain target:self action:@selector(popToLastPage)];
   
}
- (void)scan{

}
- (void)popToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)left_BarButtonItemAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)right_BarButtonItemAction {
    [self.webView reloadData];
}

// 添加Label，加载扫描过来的内容
- (void)setupLabel {
    // 提示文字
    UILabel *prompt_message = [[UILabel alloc] init];
    prompt_message.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    prompt_message.text = @"您扫描的条形码结果如下： ";
    prompt_message.textColor = [UIColor redColor];
    prompt_message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:prompt_message];
    
    // 扫描结果
    CGFloat label_Y = CGRectGetMaxY(prompt_message.frame);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, label_Y, self.view.frame.size.width, 30);
    label.text = self.jump_bar_code;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    CGFloat webViewX = 0;
    CGFloat webViewY = 0;
    CGFloat webViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webViewH = [UIScreen mainScreen].bounds.size.height;
    self.webView = [SGWebView webViewWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    _webView.progressViewColor = [UIColor redColor];
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
}

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    NSLog(@"didFinishLoad");
    //self.title = webView.navigationItemTitle;
}

@end


