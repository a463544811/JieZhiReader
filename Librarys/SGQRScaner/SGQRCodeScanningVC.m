//
//  SGQRCodeScanningVC.m
//  SGQRCodeExample
//
//  Created by apple on 17/3/20.
//  Copyright © 2017年 Sorgle. All rights reserved.
//

#import "SGQRCodeScanningVC.h"
#import "SGQRCode.h"
#import "ScanSuccessJumpVC.h"
#import "UIColor+TJZExt.h"
#import "TJZBookDetailViewController.h"
#import "TJZCodeWrongViewController.h"
@interface SGQRCodeScanningVC () <SGQRCodeManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@end

@implementation SGQRCodeScanningVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    
    [self setupQRCodeScanning];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self setupNavigationBar];
    
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

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)setupNavigationBar {
     [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorFromHexString:@"#65c9a1"]] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorFromHexString:@"#ffffff"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#ffffff"]}];
    self.navigationItem.title = @"扫一扫";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToLastPage)];
}
- (void)popToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItenAction {
    /// 从相册中读取二维码
    SGQRCodeManager *manager = [SGQRCodeManager sharedQRCodeManager];
    [manager SG_readQRCodeFromAlbum];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 栅栏函数
    dispatch_barrier_async(queue, ^{
        BOOL isPHAuthorization = manager.isPHAuthorization;
        if (isPHAuthorization == YES) {
            [self removeScanningView];
        }
    });
}

- (void)setupQRCodeScanning {
    SGQRCodeManager *manager = [SGQRCodeManager sharedQRCodeManager];
    manager.currentVC = self;
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr];
    manager.delegate = self;
    //    manager.isOpenLog = NO;
}

#pragma mark - - - SGQRCodeManagerDelegate
- (void)QRCodeManagerDidCancelWithImagePickerController:(SGQRCodeManager *)QRCodeManager {
    [self.view addSubview:self.scanningView];
}

- (void)QRCodeManager:(SGQRCodeManager *)QRCodeManager didFinishPickingMediaWithResult:(NSString *)result {
    if ([result hasPrefix:@"http"]) {
        TJZBookDetailViewController *jumpVC = [[TJZBookDetailViewController alloc] init];
        [self.navigationController pushViewController:jumpVC animated:YES];
        
    } else {
        TJZBookDetailViewController *jumpVC = [[TJZBookDetailViewController alloc] init];
        [self.navigationController pushViewController:jumpVC animated:YES];
    }
}

- (void)QRCodeManager:(SGQRCodeManager *)QRCodeManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [QRCodeManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [QRCodeManager SG_stopRunning];
        [QRCodeManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        TJZBookDetailViewController *jumpVC = [[TJZBookDetailViewController alloc] init];
        jumpVC.resultUrl = obj.stringValue;
       // [jumpVC fetchData];
        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
        NSLog(@"暂未识别出扫描的二维码");
        TJZCodeWrongViewController *vc = [TJZCodeWrongViewController new];
        [self.navigationController pushViewController: vc animated:YES];
    }
}


@end

