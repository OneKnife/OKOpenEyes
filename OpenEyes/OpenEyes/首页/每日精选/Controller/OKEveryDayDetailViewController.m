//
//  OKEveryDayDetailViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKEveryDayDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "OKPlayViewController.h"
#import "UIButton+WebCache.h"
#import "AFNetworking.h"
#import "OKDownloadManager.h"



@implementation OKEveryDayDetailViewController
{
    UILabel * _titleLabel;
    
    UILabel * _detalLabel;
    UIImageView  * _coverView;
    UILabel * _durationLabel;
    
    
    UIButton * _collectButton;
    UIButton * _shareButton;
    UIButton * _downloadButton;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)createUI
{
 
    //下部按钮
//    _collectButton=[UIButton buttonWithType:]
    
    

    _coverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    [_coverView sd_setImageWithURL:[NSURL URLWithString:_model.coverForFeed]];
    UIControl * control =[[UIControl alloc] initWithFrame:_coverView.bounds];
    [_coverView setUserInteractionEnabled:YES];
    [_coverView addSubview:control];
    [control addTarget:self action:@selector(playOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_coverView];
    
    
    
    //下部背景
    
    UIImageView * buttomImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 264, SCREEN_WIDTH, SCREEN_HEIGHT-264)];
    [buttomImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverBlurred]];
    [self.view addSubview:buttomImageView];
    
    
    
    
    _titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 280, SCREEN_WIDTH-25, 20)];
    _titleLabel.text=self.model.title;
    _titleLabel.textColor=[UIColor whiteColor];
    _titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:_titleLabel];
    
    UIView * line =[[UIView alloc] initWithFrame:CGRectMake(15, 310, 100, 1)];
    line.backgroundColor=[UIColor whiteColor];
    line.alpha=0.3;
    [self.view addSubview:line];
    
    //分类 时间label
    NSInteger duration =_model.duration.integerValue;
    
    _durationLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 320, 150, 15)];
    _durationLabel.text =[NSString stringWithFormat:@"#%@ %.2d'%.2d\"",_model.category,duration/60,duration%60];
    _durationLabel.font=[UIFont systemFontOfSize:13];
    _durationLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:_durationLabel];
    
    _detalLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 340, SCREEN_WIDTH-30, 80)];
    _detalLabel.textColor=[UIColor whiteColor];
    _detalLabel.text=_model.desc;
    _detalLabel.numberOfLines=0;
    _detalLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:_detalLabel];
 
    UIButton * downLoad =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 420, 20, 20)];
//    downLoad.image=[UIImage imageNamed:@"download"];
    [downLoad setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [downLoad addTarget:self action:@selector(downloadOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downLoad];
    
    
}



-(void)playOnclick
{
//    OKPlayViewController * playController =[[OKPlayViewController alloc] init];
//    playController.url=self.model.playUrl;
//    
//    [self.navigationController pushViewController:playController animated:YES];
//    
    
    OKPlayViewController*vc=[[OKPlayViewController alloc]initWithContentURL:[NSURL URLWithString:self.model.playUrl]];
    [vc.moviePlayer prepareToPlay];
//    vc.moviePlayer.controlStyle=MPMovieControlStyleNone;
    [vc.moviePlayer play];
    [self presentViewController:vc animated:YES completion:nil];
    

/*
    NSLog(@"%@",vc.view.subviews);
    NSLog(@"%@",[vc.view.subviews[0] subviews]);
    NSLog(@"%@",[[vc.view.subviews[0] subviews][0] subviews]);

    NSLog(@"%@",[[[vc.view.subviews[0] subviews][0] subviews][4] subviews]);

    UIView * controlView =[[vc.view.subviews[0] subviews][0] subviews][4];
    
    UIView * buttomView =[controlView subviews][0];
    UIView * topView= [controlView subviews][1];
    
    for (UIView * v in topView.subviews) {
        [v removeFromSuperview];
    }
    
    
    NSLog(@"%@",buttomView);
    NSLog(@"%@",buttomView.subviews);
    buttomView.backgroundColor=[UIColor clearColor];
    
    for (UIView * v in buttomView.subviews) {
        [v removeFromSuperview];
    }
    
    
    
    UIView * newButtomView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    
    UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"播放" forState:UIControlStateNormal];
    
    [button setBackgroundColor:[UIColor redColor]];
    [newButtomView addSubview:button];
    [buttomView addSubview:newButtomView];
*/
 
}


-(void)downloadOnClick
{
    NSLog(@"下载click");
    
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.playUrl]];
//    
//    AFHTTPRequestOperation * operation =[[AFHTTPRequestOperation alloc]initWithRequest:request];
//    operation
    OKDownloadManager * manager =[OKDownloadManager manager];
    
    if ([manager isFileExsits:self.model]) {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"该视频正在下载中" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    [manager addDownloadTastWithModel:self.model];
    
    
}


@end
