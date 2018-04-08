//
//  ViewController.m
//  CustomLayout
//
//  Created by Gavin on 2018/3/24.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "ViewController.h"
#import "GWModel.h"
#import <MJExtension.h>


#define ScreenSize [UIScreen mainScreen].bounds.size
#define cellID @"cellID"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

// 数据源
@property (nonatomic, strong) NSMutableArray<GWModel *> *dataSource;
// 表格
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    [self initData];
}
- (void)initData {
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"geojson"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *coordinates = dic[@"coordinates"];
    // 数据转模型
    NSMutableArray *dataSource = [GWModel mj_objectArrayWithKeyValuesArray:coordinates];
    
    [self.dataSource addObjectsFromArray:dataSource];
    
    
}
- (void)initUI {
    
    self.title = @"自定义布局实现";
    // 添加表格视图
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    GWModel *model = self.dataSource[indexPath.row];
    
    NSString *targeVcStr = model.targeVc;
    
    Class class = NSClassFromString(targeVcStr);
    UIViewController *targeVc = [[class alloc] init];
    targeVc.title = model.title;
    
    [self.navigationController pushViewController:targeVc animated:true];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    GWModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    
    return cell;
}

#pragma mark - 懒加载
// 表格
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        
    }
    
    return _tableView;
}

// 数据源
- (NSMutableArray<GWModel *> *)dataSource {
    
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray new];
    }
    
    return _dataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
