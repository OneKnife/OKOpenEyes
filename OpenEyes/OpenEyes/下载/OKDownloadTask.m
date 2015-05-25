//
//  OKDownloadTask.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadTask.h"
#import "AFNetworking.h"
#import "OKDownloadManager.h"
@implementation OKDownloadTask
{
    AFHTTPRequestOperation * _operation;
}
-(instancetype)initWithModel:(OKEveryDayModel *)model
{
    
    self=[super init] ;
    if (!self) {
        return nil;
    }
    
    _model=model;
    
    _operation =[[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.playUrl]]];
    
    
    NSString * downloadPath = NSHomeDirectory();
    downloadPath = [downloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/%@.mp4",model.id]];
    NSLog(@"%@",downloadPath);
    
    _operation.outputStream=[NSOutputStream outputStreamToFileAtPath:downloadPath append:NO];
    
    
    __weak typeof(self) weakSelf =self;
    
    //进度
    [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        weakSelf.downloadBytes=[weakSelf formatByteCount:totalBytesRead];
        weakSelf.totalBytes=[weakSelf formatByteCount:totalBytesExpectedToRead];
        weakSelf.progress=(double)totalBytesRead/totalBytesExpectedToRead;
        
        
        NSLog(@"%@/%@",weakSelf.downloadBytes,weakSelf.totalBytes);
        
    }];
    
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.complete=YES;
        weakSelf.downloading=NO;
        
        OKDownloadManager * manager= [OKDownloadManager manager];
        [manager endDownloadWithTask:weakSelf];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.complete=NO;
        weakSelf.error=error.localizedDescription;
        weakSelf.downloading=NO;
    }];
    
    
    
    
    return self;
}


-(NSString *)formatByteCount:(long long)bytes
{
    return [NSByteCountFormatter stringFromByteCount:bytes countStyle:NSByteCountFormatterCountStyleFile];
}

-(void)start
{
    [_operation start];
    self.downloading=YES;
}

-(void)stop
{
    [_operation cancel];
    self.downloading=NO;
}
-(void)pause
{
    [_operation pause];
    self.downloading=NO;
}

-(void)resume
{
    [_operation resume];
    self.downloading=YES;
}


@end
