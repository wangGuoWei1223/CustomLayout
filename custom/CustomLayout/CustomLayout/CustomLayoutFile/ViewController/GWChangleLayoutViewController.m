//
//  GWChangleLayoutViewController.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/28.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWChangleLayoutViewController.h"
#import "GWCircleLayout.h"
#import "GWLineLayout.h"
#import "GWCircleCollectionViewCell.h"

@interface GWChangleLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView; // 滚动视图
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation GWChangleLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加表格视图
    [self.view addSubview:self.collectionView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[GWLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[GWCircleLayout alloc] init] animated:true];
    }else {
        
        GWLineLayout *layout = [[GWLineLayout alloc] init];
        layout.itemSize = CGSizeMake(200, 200);
        [self.collectionView setCollectionViewLayout:layout animated:true];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataSource removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GWCircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GWCircleCollectionViewCellID forIndexPath:indexPath];
    
    NSString *title = self.dataSource[indexPath.item];
    [cell showCellWithTitle:title];
    
    return cell;
    
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        CGFloat headerCollectViewHeight = 300;
        
        GWCircleLayout *layout = [[GWCircleLayout alloc] init];
        
        CGRect frame = CGRectMake(0, 80, ScreenSize.width, headerCollectViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[GWCircleCollectionViewCell class] forCellWithReuseIdentifier:GWCircleCollectionViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    
    return _collectionView;
}

#pragma mark - 懒加载
/** 数据源 */
- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        
        _dataSource = [NSMutableArray new];
        
        for (NSInteger i = 0; i < 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
