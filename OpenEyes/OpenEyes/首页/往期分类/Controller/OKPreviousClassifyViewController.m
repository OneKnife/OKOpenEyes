//
//  OKPreviousClassifyViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKPreviousClassifyViewController.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "OKPreviousClassfyModel.h"
#import "UIImageView+WebCache.h"
#import "OKPreviousClassDetailViewController.h"

#define CATEGORY_URL @"http://baobab.wandoujia.com/api/v1/categories"


@interface OKPreviousClassifyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation OKPreviousClassifyViewController
{
    NSArray * _dataArray;
    UICollectionView * _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData
{
//    if (!_dataArray) {
//        _dataArray=[[NSMutableArray alloc] init];
//        
//    }

    NSDictionary * para = @{@"vc":@"40",
                            @"t":@"MjAxNTA1MTExNzQ3MDM4OTgsMzY3Ng%3D%3D",
                            @"u":@"6d77423c595566be44d4c93bac3809a5b7d97bda",
                            @"net":@"wifi",
                            @"v":@"1.2.0",
                            @"f":@"iphone"};
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    [manager POST:CATEGORY_URL parameters:para success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        _dataArray =[OKPreviousClassfyModel objectArrayWithKeyValuesArray:responseObject];
        [self createCollectionView];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


-(void)createCollectionView
{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor=[UIColor whiteColor];

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    for (id subviou in cell.contentView.subviews) {
        [subviou removeFromSuperview];
    }
    
    UIImageView * imgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, SCREEN_WIDTH/2-2)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[_dataArray[indexPath.row]bgPicture]]];
    
    UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(0, imgView.frame.size.height/2-10, SCREEN_WIDTH/2-2, 20)];
    label.font=[UIFont boldSystemFontOfSize:16];
    label.text=[NSString stringWithFormat:@"#%@",[_dataArray[indexPath.row] name]];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    
    [cell.contentView addSubview:imgView];
    [cell.contentView addSubview:label];
    
//    cell.contentView addObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>
    
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2-1, SCREEN_WIDTH/2-1);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKPreviousClassDetailViewController * deilVC =[[OKPreviousClassDetailViewController alloc] init];
    deilVC.categoryName=[_dataArray[indexPath.row]name];
    deilVC.title=[NSString stringWithFormat:@"#%@",deilVC.categoryName];
    
    [self.navigationController pushViewController:deilVC animated:YES];
}


@end
