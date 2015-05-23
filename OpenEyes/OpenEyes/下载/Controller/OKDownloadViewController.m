//
//  OKDownloadViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadViewController.h"
#import "OKDownloadManager.h"
#import "OKDownloadCell.h"
#import "OKDownloadTask.h"

@interface OKDownloadViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OKDownloadViewController
{
    UITableView * _tableView;
    OKDownloadManager * _manager;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager =[OKDownloadManager manager];
    [self createTableView];
    
    
    
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
    return _manager.downLoadList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKDownloadCell * cell =[tableView dequeueReusableCellWithIdentifier:@"OKDownloadCell"];
    
    OKDownloadTask * task =_manager.downLoadList[indexPath.row];
    
    OKEveryDayModel * model = [task model];
    
    cell.bgImageUrl=model.coverForDetail;
    cell.title=model.title;
    
    
    [task addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.f;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    OKDownloadTask * task =(OKDownloadTask *)object;
    NSLog(@"%lf",task.progress);
    OKDownloadCell * cell =(OKDownloadCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_manager.downloadNum inSection:0]];
    cell.progress=task.progress;
    
}



-(void)dealloc
{
    for (OKDownloadTask * task in _manager.downLoadList) {
        [task removeObserver:self forKeyPath:@"progress" context:nil];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
