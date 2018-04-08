//
//  GWBlockViewController.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/27.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//  方块布局

#import "GWBlockViewController.h"
#import "GWBlockLayout.h"
#import "GWBlockCollectionViewCell.h"

@interface GWBlockViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView; // 滚动视图


@end

@implementation GWBlockViewController

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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GWBlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GWBlockCollectionViewCellID forIndexPath:indexPath];

    NSString *title = [NSString stringWithFormat:@"%ld", indexPath.item];
    [cell showCellWithTitle:title];

    return cell;
    
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        CGFloat headerCollectViewHeight = self.view.frame.size.height - 64;
        
        GWBlockLayout *layout = [[GWBlockLayout alloc] init];

        CGRect frame = CGRectMake(0, 0, ScreenSize.width, headerCollectViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[GWBlockCollectionViewCell class] forCellWithReuseIdentifier:GWBlockCollectionViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    
    return _collectionView;
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
