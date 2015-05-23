//
//  OKEveryDayViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-9.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKEveryDayViewController.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "OKEveryDayModel.h"
#import "OKEveryDayDataModel.h"
#import "OKEveryDayListModel.h"
#import "NSDate+OK.h"
#import "OKEVeryDayCell.h"
#import "OKEveryDayDetailViewController.h"
#include "OKDownloadViewController.h"

#define EVERY_DAY_URL @"http://baobab.wandoujia.com/api/v1/feed"
//#define EVERY_DAY_URL @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%ld&vc=40&t=MjAxNTA1MTExMTQ3NTk5NDAsNDUyNA%3D%3D&u=6d77423c595566be44d4c93bac3809a5b7d97bda&net=wifi&v=1.2.0&f=iphone"
//参数 20150511


//#define EVERY_DAY_URL_@ @"http://baobab.wandoujia.com/api/v1/feed?date=20150501&num=10&vc=40&t=MjAxNTA1MTExNjA5Mzk4MzAsMTc0Nw%3D%3D&u=6d77423c595566be44d4c93bac3809a5b7d97bda&net=wifi&v=1.2.0&f=iphone"





@interface OKEveryDayViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OKEveryDayViewController
{
    OKEveryDayDataModel * _model ;
    NSString * _date;
    UITableView * _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _date=[NSDate dayStringWithDate:[NSDate date]];
    
//    NSLog(@"%lf",[[NSDate date] timeIntervalSince1970]);
    [self requestData];
    
//    NSLog(@"%@", [NSDate dayStringWithDate:[NSDate date]]);
    
    [self customNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customNavigationBar
{
    UIButton * leftButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton addTarget:self action:@selector(leftOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBarButton;
}


//左按钮
-(void)leftOnClick
{
    OKDownloadViewController * downloadController =[[OKDownloadViewController alloc] init];
    [self.navigationController pushViewController:downloadController animated:YES];
}


-(void)requestData
{
//    if (!_model) {
//        _model=[[OKEveryDayDataModel alloc]init];
//    }
    
    NSDictionary * para =@{@"num":@"10",
                           @"date":_date,
                           @"vc":@"40",
                           @"t":@"MjAxNTA1MTExMTQ3NTk5NDAsNDUyNA%3D%3D",
                           @"u":@"6d77423c595566be44d4c93bac3809a5b7d97bda",
                           @"net":@"wifi",
                           @"v":@"1.2.0",
                           @"f":@"iphone"
                           };
    
    
    
    
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:EVERY_DAY_URL] parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [OKEveryDayDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"dailyList" : @"OKEveryDayListModel",
                     };
        }];
        [OKEveryDayListModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"videoList" : @"OKEveryDayModel",
                     };
        }];
        
        [OKEveryDayModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc" : @"description",
                     };
        }];
        
         _model=[OKEveryDayDataModel objectWithKeyValues:responseObject];
//        [self createTableView];
        [self performSelectorOnMainThread:@selector(createTableView) withObject:nil waitUntilDone:NO];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"every day request err!");
    }];
}

-(void)createTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.dailyList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_model.dailyList[section] videoList].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKEVeryDayCell * cell =[_tableView dequeueReusableCellWithIdentifier:@"OKEVeryDayCell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"OKEVeryDayCell" owner:nil options:nil].lastObject;
    }
    cell.model=[_model.dailyList[indexPath.section] videoList][indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 204.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKEveryDayDetailViewController * detailVC =[[OKEveryDayDetailViewController alloc] init];
    detailVC.model=[_model.dailyList[indexPath.section] videoList][indexPath.row];
    [self.navigationController pushViewController:detailVC animated:NO];
    
}


@end
