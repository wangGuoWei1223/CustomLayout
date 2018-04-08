//
//  GWWaterViewController.m
//  CustomLayout
//
//  Created by Gavin on 2018/3/29.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWWaterViewController.h"
#import "GWWaterLayout.h"
#import "GWWaterCollectionViewCell.h"

@interface GWWaterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GWWaterLayoutDelegate>


@property (nonatomic, strong) UICollectionView *collectionView; // 滚动视图


@end

@implementation GWWaterViewController

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
#pragma mark - GWWaterLayoutDelegate
- (CGFloat)waterLayout:(GWWaterLayout *)waterLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    // 这里可以更具 itemWidth的宽度来按比例技术 item的高度
    CGFloat scale = (5 + arc4random_uniform(10)) * 0.1;
    return itemWidth * scale;
}

//- (NSInteger)columnCountInWaterLayout:(GWWaterLayout *)waterLayout {
//    
//    return 4;
//}
//- (CGFloat)columnMarginInWaterLayout:(GWWaterLayout *)waterLayout {
//    return 1.0;
//}
//- (CGFloat)rowMarginInWaterLayout:(GWWaterLayout *)waterLayout {
//
//    return 1.0;
//}
//- (UIEdgeInsets)edgeInsetsInWaterLayout:(GWWaterLayout *)waterLayout {
//
//    return UIEdgeInsetsMake(3, 4, 5, 6);
//}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GWWaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GWWaterCollectionViewCellID forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"%ld", indexPath.item];
    [cell showCellWithTitle:title];
    
    return cell;
    
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        CGFloat headerCollectViewHeight = self.view.frame.size.height - 64;
        
        GWWaterLayout *layout = [[GWWaterLayout alloc] init];
        layout.delegate = self;
        
        CGRect frame = CGRectMake(0, 0, ScreenSize.width, headerCollectViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[GWWaterCollectionViewCell class] forCellWithReuseIdentifier:GWWaterCollectionViewCellID];
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
