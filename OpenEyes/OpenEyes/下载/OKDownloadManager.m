//
//  OKDownloadManager.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadManager.h"
#import "OKDownloadTask.h"




static OKDownloadManager * manager;

@implementation OKDownloadManager

+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[OKDownloadManager alloc] init];
        
        
    });
    
    return manager;
}

-(instancetype)init
{
    if (self=[super  init]) {
        
        NSFileManager * fileManager =[[NSFileManager alloc]init];
        
        /**所有的任务*/
        
        if ([fileManager fileExistsAtPath:DOWNLOAD_FILE_PATH]) {
            
            _downLoadList=[NSMutableArray arrayWithContentsOfFile:DOWNLOAD_FILE_PATH];
        }
        else
        {
            _downLoadList=[[NSMutableArray alloc] init];
        }
        
        
        /**下载完成的任务*/
        
        if ([fileManager fileExistsAtPath:DOWNLOADED_FILE_PATH]) {
            
            _downloadedList=[NSMutableArray arrayWithContentsOfFile:DOWNLOADED_FILE_PATH];
        }
        else
        {
            _downloadedList=[[NSMutableArray alloc] init];
        }
       
        
        
    }
    return self;
}

-(void)addDownloadTastWithModel:(OKEveryDayModel *)model
{
    OKDownloadTask * task =[[OKDownloadTask alloc] initWithModel:model];
    [_downLoadList addObject:task];
    

    //当有视频下载时 后续的视频排队等待
    if (![self downloadingItem]) {
        [task start];
        _downloadNum= [_downLoadList indexOfObject:task];
    }
    
    
//    for (NSInteger i =1; i<_downLoadList.count; i++) {
//        
//        OKDownloadTask * task = _downLoadList[i];
//        if (task.isDownloading==YES) {
//            [task pause];
//            break;
//        }
//    }
}

-(BOOL)isFileExsits:(OKEveryDayModel *)model
{
    for (OKDownloadTask * task in _downLoadList) {
        if (task.model==model) {
            return YES;
        }
    }
    return NO;
}


-(void)selectWithIndex:(NSInteger)index
{
    OKDownloadTask * task = self.downLoadList[index];
    if (index==self.downloadNum) {
        if (task.isDownloading==YES) {
            [task pause];
            task.downloading=NO;
        }
        else
        {
            //resume
            [task resume];
            task.downloading=YES;
        }
    }
    else
    {
        _downloadNum=index;
        
        OKDownloadTask * downloadTask =[self downloadingItem];
        downloadTask.downloading=NO;
        [downloadTask pause];
        
        task.downloading=YES;
        
        if (task.progress==0) {
            [task start];
        }
        else
        {
            //resume
            [task resume];
        }
    }
}

/**返回当前正在下载项*/
-(OKDownloadTask *)downloadingItem
{
    NSLog(@"%@",NSHomeDirectory());
    
    for (OKDownloadTask * task in _downLoadList) {
        if (task.isDownloading==YES) {
            return task;
        }
    }
    return nil;
}

-(void)endDownloadWithTask:(OKDownloadTask *)task
{
    
    NSDictionary * tas =@{
                          @"id":task.model.id,
                          @"title":task.model.title,
                          @"coverForDetail":task.model.coverForDetail,
                          };
    
    [_downloadedList addObject:tas];
    
    [_downloadedList writeToFile:DOWNLOADED_FILE_PATH atomically:YES];
    
}





@end
