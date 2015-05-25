//
//  OKPreviousClassDetailViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//



//http://baobab.wandoujia.com/api/v1/videos?num=10&categoryName=%E5%88%9B%E6%84%8F&vc=40&t=MjAxNTA1MjMyMTQ2NTY3OTMsOTQ0Mw%3D%3D&u=6d77423c595566be44d4c93bac3809a5b7d97bda&net=wifi&v=1.2.0&f=iphone

#define LIST_URL @"http://baobab.wandoujia.com/api/v1/videos"

#import "OKPreviousClassDetailViewController.h"
#import "AFNetworking.h"
#import "OKEveryDayModel.h"
#import "OKEveryDayDataModel.h"
#import "MJExtension.h"
#import "OKEveryDayListModel.h"
#import "OKEVeryDayCell.h"
#import "OKEveryDayDetailViewController.h"

@interface OKPreviousClassDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OKPreviousClassDetailViewController
{
    OKEveryDayListModel * _model ;
    UITableView * _tableView;

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
    AFHTTPSessionManager * manager =[AFHTTPSessionManager manager];
    
    NSDictionary * para =@{@"num":@"10",
                           @"categoryName":self.categoryName,
                           @"vc":@"40",
                           @"t":@"MjAxNTA1MTExMTQ3NTk5NDAsNDUyNA%3D%3D",
                           @"u":@"6d77423c595566be44d4c93bac3809a5b7d97bda",
                           @"net":@"wifi",
                           @"v":@"1.2.0",
                           @"f":@"iphone"
                           };
    

    [manager GET:LIST_URL parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        [OKEveryDayDataModel setupObjectClassInArray:^NSDictionary *{
//            return @{
//                     @"dailyList" : @"OKEveryDayListModel",
//                     };
//        }];
        [OKEveryDayListModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"videoList" : @"OKEveryDayModel",
                     };
        }];
        
        [OKEveryDayModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc" : @"description",
                     };
        }];
        
        _model=[OKEveryDayListModel objectWithKeyValues:responseObject];
        //        [self createTableView];
        [self performSelectorOnMainThread:@selector(createTableView) withObject:nil waitUntilDone:NO];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.videoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKEVeryDayCell * cell =[_tableView dequeueReusableCellWithIdentifier:@"OKEVeryDayCell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"OKEVeryDayCell" owner:nil options:nil].lastObject;
    }
    cell.model=_model.videoList[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 204.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKEveryDayDetailViewController * detailVC =[[OKEveryDayDetailViewController alloc] init];
    detailVC.model=[_model videoList][indexPath.row];
    [self.navigationController pushViewController:detailVC animated:NO];
    
}



@end
