//
//  TJZAllStyleReadViewController.m
//  JieZhiReader
//
//  Created by tjut on 17/6/26.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZAllStyleReadViewController.h"
#import "LDCCollectionView.h"
#import "UIColor+TJZExt.h"
#import "TJZMainPageCollectionViewCell.h"
#import "TJZLastCollectionViewCell.h"
#import "LSYReadPageViewController.h"
#import "TJZFileDownLoader.h"
#import "TJZBookInfoLocalDataUitl.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerateVC.h"
#import "SGQRCodeScanningVC.h"
#import "TJZAlertViewController.h"

#define kScreenHeigth [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface TJZAllStyleReadViewController ()<LDCCollectionDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet LDCCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *buttomView;
@property (nonatomic,assign) BOOL isEdict;
@property (nonatomic,strong) NSString *fullPath;
@property (nonatomic,strong) NSMutableArray *contentArray;
@end

@implementation TJZAllStyleReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView.ldcDelegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"TJZMainPageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TJZMainPageCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"TJZLastCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TJZLastCollectionViewCell"];
    _buttomViewHeightConstraint.constant = 0;
    _buttomView.hidden = YES;
    _contentArray = [NSMutableArray new];
    [self getLocalData];
    
    
    
}
- (void)getLocalData{
    NSMutableArray *array = [TJZBookInfoLocalDataUitl selectAllData];
    if (array.count>0) {
      [_contentArray addObjectsFromArray:array];
      [_collectionView reloadData];
    }
    
}
- (void)edit:(BOOL)isDelete{
    _isEdict = isDelete;
    if (isDelete) {
        _buttomViewHeightConstraint.constant = 50;
        _buttomView.hidden = NO;
    }else{
        _buttomViewHeightConstraint.constant = 0;
        _buttomView.hidden = YES;
    }
    [_collectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_contentArray.count == 0) {
        TJZLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJZLastCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        if (indexPath.row == _contentArray.count) {
            TJZLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJZLastCollectionViewCell" forIndexPath:indexPath];
            return cell;
        }else{
            TJZMainPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJZMainPageCollectionViewCell" forIndexPath:indexPath];
            [cell showCellDataWithModel:_contentArray[indexPath.row] isEdict:_isEdict];
            return cell;

        }
    }
       
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-64)/3, 175);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _contentArray.count) {
        
        [self scan];
        
    }else{
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"20 上午9.59.15"withExtension:@"epub"];
        LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
        pageView.resourceURL = fileURL;    //文件位置
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self presentViewController:pageView animated:YES completion:nil];
            });
        });

    }
    
    
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

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *fullPath = [
                          [TJZFileDownLoader documentsDirectory]stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    
    NSLog(@"++++++%@",fullPath);
    _fullPath = fullPath;
   
   
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
    NSURL *fileURL = [NSURL fileURLWithPath:_fullPath];
    pageView.resourceURL = fileURL;    //文件位置
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self presentViewController:pageView animated:YES completion:nil];
        });
    });

}
//删除
- (IBAction)deleteBooks:(UIButton *)sender {
    
   
    
        TJZAlertViewController *alertVC = [TJZAlertViewController alertControllerWithTitle:@"温馨提示" message:@"您是否确认删除已选中图书?"];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        TJZAlertAction *cancel = [TJZAlertAction actionWithTitle:@"取消" handler:^(TJZAlertAction *action) {
    
        }];
        TJZAlertAction *sure = [TJZAlertAction actionWithTitle:@"确定" handler:^(TJZAlertAction *action) {
    
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:sure];
        [self presentViewController:alertVC animated:NO completion:nil];

}

@end
