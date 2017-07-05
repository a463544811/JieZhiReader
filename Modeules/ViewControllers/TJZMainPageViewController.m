//
//  TJZMainPageViewController.m
//  JieZhiReader
//
//  Created by tjut on 17/6/26.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZMainPageViewController.h"
#import "LDCTableView.h"
#import "TJZAllStyleReadViewController.h"
#import "UIColor+TJZExt.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerateVC.h"
#import "SGQRCodeScanningVC.h"

@interface TJZMainPageViewController ()
{
    NSArray *_vcArray;
    NSInteger _currentIndex;
    BOOL _isDelete;

}
@property (weak, nonatomic) IBOutlet UIButton *latestButton;
@property (nonatomic,strong) UIButton *lastButton;
@property (nonatomic,strong) UIButton *rightButton;
@end

@implementation TJZMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeRight;
    _latestButton.backgroundColor = [UIColor colorFromHexString:@"#8fdebe"];
    _lastButton = _latestButton;
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = @"中版数字图书馆";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#404040"]}];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"tab_scan"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton setTitleColor:[UIColor colorFromHexString:@"#65c9a1"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(edict) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    
}
- (void)scan{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)edict{
    
   _isDelete = !_isDelete;
    TJZAllStyleReadViewController *vc = _vcArray[_currentIndex];
    [vc edit:_isDelete];
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
- (NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController{
    TJZAllStyleReadViewController *latest = [TJZAllStyleReadViewController new];
    latest.type = stateTypeLatestRead;
    TJZAllStyleReadViewController *alreadyRead = [TJZAllStyleReadViewController new];
    latest.type = stateTypeAlreadyRead;
    TJZAllStyleReadViewController *noneRead = [TJZAllStyleReadViewController new];
    noneRead.type = stateTypeNoneRead;
    TJZAllStyleReadViewController *Allreaded = [TJZAllStyleReadViewController new];
    Allreaded.type = stateTypeAllRead;
    _vcArray = @[latest,alreadyRead,noneRead,Allreaded];
    return  _vcArray;
}
- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
           updateIndicatorFromIndex:(NSInteger)fromIndex
                            toIndex:(NSInteger)toIndex{
    [self setBackgroundColorWithIndex:toIndex];
    _currentIndex = toIndex;
}
- (IBAction)changeViewController:(UIButton *)sender {
     [self setBackgroundColorWithIndex:sender.tag - 100 ];
     [self moveToViewControllerAtIndex:sender.tag - 100];
    _currentIndex = sender.tag - 100;
}

- (void)setBackgroundColorWithIndex:(NSInteger)index{
    UIButton *sender = (UIButton *)[self.view viewWithTag:index + 100];
    _lastButton.backgroundColor = [UIColor clearColor];
    sender.backgroundColor = [UIColor colorFromHexString:@"#8fdebe"];
    _lastButton = sender;
    
}
@end
