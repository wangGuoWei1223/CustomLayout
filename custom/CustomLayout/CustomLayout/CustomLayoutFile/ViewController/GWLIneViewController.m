//
//  GWLIneViewController.m
//  自定义布局
//
//  Created by Gavin on 2018/3/24.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//  流水布局

#import "GWLIneViewController.h"
#import "GWLineCollectionViewCell.h"
#import "GWLineLayout.h"

@interface GWLIneViewController()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView; // 滚动视图

@end

@implementation GWLIneViewController

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
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GWLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GWLineCollectionViewCellID forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"%ld", indexPath.item];
    [cell showCellWithTitle:title];
    
    return cell;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        CGFloat headerCollectViewHeight = 160;
        CGFloat ItemTopEdgeInset = 10.0;
        
        GWLineLayout *layout = [[GWLineLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(ItemTopEdgeInset, 0, 0, 0);
        
        CGFloat itemHeight = 150;
        CGFloat itemWidth = 2 * itemHeight;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumInteritemSpacing = 17.0;
        
        CGRect frame = CGRectMake(0, 80, ScreenSize.width, headerCollectViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[GWCollectionViewCell class] forCellWithReuseIdentifier:GWLineCollectionViewCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = false;
        
        CGFloat topBottomEdgeInset = (ScreenSize.width - itemWidth) * 0.5;
        //        _collectionView.contentInset = UIEdgeInsetsMake(0, topBottomEdgeInset, 0, topBottomEdgeInset);
    }
    
    return _collectionView;
}


@end
