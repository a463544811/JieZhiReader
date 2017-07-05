//
//  LSYChapterVC.m
//  LSYReader
//
//  Created by okwei on 16/6/2.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYChapterVC.h"
#import "LSYCatalogViewController.h"
#import "UIColor+TJZExt.h"

static  NSString *chapterCell = @"chapterCell";
@interface LSYChapterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tabView;
@property (nonatomic) NSUInteger readChapter;
@property (strong, nonatomic) UIImageView * lineImageView;
@end

@implementation LSYChapterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tabView];
    [self addObserver:self forKeyPath:@"readModel.record.chapter" options:NSKeyValueObservingOptionNew context:NULL];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [_tabView reloadData];
    
}
-(UITableView *)tabView
{
    if (!_tabView) {
        _tabView = [[UITableView alloc] init];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabView;
}

- (UIImageView *)lineImageView{
    _lineImageView = [[UIImageView alloc] init];
    _lineImageView.frame = CGRectMake(20, 43, self.view.bounds.size.width, 1);
    _lineImageView.backgroundColor = [UIColor colorWithHex:@"#edf2f1"];
    return _lineImageView;
}

#pragma mark - UITableView Delagete DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _readModel.chapters.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chapterCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chapterCell];
    }
    cell.textLabel.text = _readModel.chapters[indexPath.row].title;
    if (indexPath.row == _readModel.record.chapter) {
        cell.textLabel.textColor = [UIColor colorFromHexString:@"#65c9a1"];
    }else{
        cell.textLabel.textColor = [UIColor colorFromHexString:@"#404040"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.lineImageView];
    cell.indentationWidth = 30.f;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(catalog:didSelectChapter:page:)]) {
        [self.delegate catalog:nil didSelectChapter:indexPath.row page:0];
    }
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"readModel.record.chapter"];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _tabView.frame = CGRectMake(0, 0, ViewSize(self.view).width, ViewSize(self.view).height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
