//
//  TJZBookDirectoryViewController.m
//  JieZhiReader
//
//  Created by tu on 2017/6/29.
//  Copyright © 2017年 long. All rights reserved.
//

#import "TJZBookDirectoryViewController.h"
#import "LDCTableView.h"
#import "TJZBookMenuModel.h"
#import "Node.h"
#import "UIColor+TJZExt.h"

@interface TJZBookDirectoryViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _menuCount;
    NSInteger _indexRow;
}
@property (weak, nonatomic) IBOutlet LDCTableView *tableView;
@property (nonatomic, strong) NSMutableArray * bookMenuArray;
@property (nonatomic, strong) NSMutableArray * testMenuArray;
@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（部分数据）
@property (nonatomic , strong) NSArray *data;//传递过来已经组织好的数据（全量数据）
@property (strong, nonatomic) IBOutlet UIView *directoryView;
@property (strong, nonatomic) UIImageView * lineImageView;

@end

@implementation TJZBookDirectoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"择天记";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.directoryView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    TJZBookMenuModel * model1 = [TJZBookMenuModel new];
    model1.title = @"序 下山";
    
    TJZBookMenuModel * model2 = [TJZBookMenuModel new];
    model2.title = @"第一章 我改主意了";
    
    TJZBookMenuModel * model3 = [TJZBookMenuModel new];
    model3.title = @"第二章 为什么";
    
    TJZBookMenuModel * model4 = [TJZBookMenuModel new];
    model4.title = @"第三章 这是个俗气的名字.但.是我的名字";
    
    TJZBookMenuModel * model5 = [TJZBookMenuModel new];
    model5.title = @"第四章 天道院";
    
    TJZBookMenuModel * model6 = [TJZBookMenuModel new];
    model6.title = @"第五章 青衣少年三十六";
    
    TJZBookMenuModel * model7 = [TJZBookMenuModel new];
    model7.title = @"第六章 开卷有喜";
    
    TJZBookMenuModel * model8 = [TJZBookMenuModel new];
    model8.title = @"第七章 陈唐相遇";
    
    TJZBookMenuModel * model9 = [TJZBookMenuModel new];
    model9.title = @"第八章 摘星";
    
    [self.bookMenuArray addObject:model1];
    [self.bookMenuArray addObject:model2];
    [self.bookMenuArray addObject:model3];
    [self.bookMenuArray addObject:model4];
    [self.bookMenuArray addObject:model5];
    [self.bookMenuArray addObject:model6];
    [self.bookMenuArray addObject:model7];
    [self.bookMenuArray addObject:model8];
    [self.bookMenuArray addObject:model9];
    [self bookMenuList];
}

-(void)bookMenuList{
    int i = 0;
    int j = 0;
    for (TJZBookMenuModel * model in self.bookMenuArray) {
        Node *country1 = [[Node alloc] initWithParentId:-1 nodeId:j name:model.title depth:0 expand:YES];
        [self.testMenuArray addObject:country1];
        i = j;
        i++;
        j = i;
    }
    _data = self.testMenuArray;
    _tempData = [self createTempData:self.testMenuArray];
    [self.tableView reloadData];
}

- (IBAction)backClick:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *)createTempData : (NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<data.count; i++) {
        Node *node = [_data objectAtIndex:i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}

-(NSMutableArray *)bookMenuArray{
    if (!_bookMenuArray) {
        _bookMenuArray = [NSMutableArray array];
    }
    return _bookMenuArray;
}

-(NSMutableArray *)testMenuArray{
    if (!_testMenuArray) {
        _testMenuArray = [NSMutableArray array];
    }
    return _testMenuArray;
}

- (UIImageView *)lineImageView{
    _lineImageView = [[UIImageView alloc] init];
    _lineImageView.frame = CGRectMake(20, 43, self.view.bounds.size.width, 1);
    _lineImageView.backgroundColor = [UIColor colorWithHex:@"#edf2f1"];
    return _lineImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *NODE_CELL_ID = @"node_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Node *node = [_tempData objectAtIndex:indexPath.row];
    // cell有缩进的方法
    cell.indentationLevel = node.depth; // 缩进级别
    cell.indentationWidth = 30.f; // 每个缩进级别的距离
    cell.textLabel.text = node.name;
    if (indexPath.row == _indexRow && _indexRow != 0) {
       cell.textLabel.textColor = [UIColor colorFromHexString:@"#65c9a1"];
    }else{
        cell.textLabel.textColor = [UIColor colorFromHexString:@"#404040"];
    }
    [cell addSubview:self.lineImageView];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _indexRow = indexPath.row;
    Node *parentNode = [_tempData objectAtIndex:indexPath.row];
    NSUInteger startPosition = indexPath.row+1;
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    for (int i=0; i<_data.count; i++) {
        Node *node = [_data objectAtIndex:i];
        if (node.parentId == parentNode.nodeId) {
            node.expand = !node.expand;
            if (node.expand) {
                [_tempData insertObject:node atIndex:endPosition];
            _menuCount = _tempData.count;
            expand = YES;
            endPosition++;
        }else{
            expand = NO;
            //endPosition = [self removeAllNodesAtParentNode:parentNode];
            break;
        }
        }
    }
    [self.tableView reloadData];

}

@end
