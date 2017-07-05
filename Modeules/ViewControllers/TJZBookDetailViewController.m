//
//  TJZBookDetailViewController.m
//  JieZhiReader
//
//  Created by tjut on 17/6/27.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookDetailViewController.h"
#import "UIColor+TJZExt.h"
#import "TJZBookDetaileTableViewCell.h"
#import "TJZBookHeaderTableViewCell.h"
#import "TJZTableViewCellHeightCache.h"
#import "Mantle.h"
#import "TJZBookModel.h"
#import "LDCTableView.h"
#import "TJZFileDownLoader.h"
#import "LSYReadPageViewController.h"
#import "TJZBookInfoLocalDataUitl.h"

@interface TJZBookDetailViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDownloadDelegate>
{
    TJZBookModel * _bookModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TJZTableViewCellHeightCache *tableViewCellHeightCache;
//@property (nonatomic,strong) TJZBookModel *bookModel;
@property (nonatomic,strong) UIButton *downLoadButton;
@end

@implementation TJZBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"TJZBookHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"TJZBookHeaderTableViewCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"TJZBookDetaileTableViewCell" bundle:nil] forCellReuseIdentifier:@"TJZBookDetaileTableViewCell"];
    self.tableViewCellHeightCache = [[TJZTableViewCellHeightCache alloc]initWithEstimatedHeight:176];
    [self fetchData];
    //_bookModel = [[TJZBookModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setupNavigationItem];
}

- (void)fetchData{
    NSString *newString = [_resultUrl stringByReplacingOccurrencesOfString:@"OpenBook" withString:@"DownloadBook"];
   NSString *uuidString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *resultString = [NSString stringWithFormat:@"%@&appid=%@",newString,uuidString];
    NSURL *url = [NSURL URLWithString:resultString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                 if (data) {
                     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                     _bookModel = [MTLJSONAdapter modelOfClass:[TJZBookModel class] fromJSONDictionary:dict error:nil];
                     [_tableView reloadData];
                     
         }
         
     }];
    [task resume];
}
- (void)setupNavigationItem {
    self.title = @"中版数字图书馆";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexString:@"#404040"]}];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"tab_scan"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"tab_back1"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(popToLastPage) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)scan{
    
}
- (void)popToLastPage {
    [self.navigationController popToRootViewControllerAnimated:YES];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_bookModel) {
        return 2;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TJZBookHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJZBookHeaderTableViewCell"];
        [cell addCellDataWithModel:_bookModel];
        return cell;
    }else{
        TJZBookDetaileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJZBookDetaileTableViewCell"];
        cell.introduce.text = _bookModel.Info;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_tableViewCellHeightCache tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableViewCellHeightCache tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (IBAction)backToLibray:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)downLoad:(UIButton *)sender{
    NSURL *url = [NSURL URLWithString:_bookModel.BookURL];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];

}
#pragma mark -- downLoadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *fullPath = [
                          [TJZFileDownLoader documentsDirectory]stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    _bookModel.BookURL = fullPath;
    [TJZBookInfoLocalDataUitl  insertBook:_bookModel];
    NSLog(@"++++++%@",fullPath);
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
   }
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
   float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    
}
@end
