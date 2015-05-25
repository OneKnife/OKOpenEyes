//
//  OKDownloadViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadedViewController.h"
#import "OKDownloadCell.h"
#import "OKDownloadTask.h"

@interface OKDownloadedViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OKDownloadedViewController
{
    UITableView * _tableView;
    NSArray * _downloadedArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    NSFileManager * fm =[NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:DOWNLOADED_FILE_PATH]) {
        _downloadedArray=[NSArray arrayWithContentsOfFile:DOWNLOADED_FILE_PATH];
    }
    else
    {
        _downloadedArray=[[NSArray alloc] init];
    }
    
}


-(void)createTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    
    [self.view addSubview:_tableView];
    
    UINib * nib =[UINib nibWithNibName:@"OKDownloadCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"OKDownloadCell"];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _downloadedArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKDownloadCell * cell =[tableView dequeueReusableCellWithIdentifier:@"OKDownloadCell"];
  
    
    
    cell.bgImageUrl= _downloadedArray[indexPath.row][@"coverForDetail"];
    cell.title=_downloadedArray[indexPath.row][@"title"];
    cell.progress=1;
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.f;
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
}


-(void)dealloc
{
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
