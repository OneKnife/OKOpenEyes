//
//  OKPlayViewController.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-12.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKPlayViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface OKPlayViewController ()

@property (nonatomic,weak) MPMoviePlayerViewController * playCtrl;

@property (nonatomic,weak) MPMoviePlayerController * player;

@end

@implementation OKPlayViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}




-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}





@end
