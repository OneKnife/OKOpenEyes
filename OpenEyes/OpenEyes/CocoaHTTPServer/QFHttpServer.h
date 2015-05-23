//
//  QFHttpServer.h
//  MediaStreamPlayAndDownload
//
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

/*
    导入官方库
    CFNetWoking.framework
    Security.framework
    libxml2.dylib
    MediaPlayer.framework
 
    设置Header search path
    添加
    /usr/include/libxml2
*/

@interface QFHttpServer : NSObject {
    HTTPServer *httpServer;
}

+ (id) sharedInstance;
//启动本地server
- (void) startHttpService;
//为视频设定存储路径
- (NSString *) getWebRoot;
//将网络地址转化成本地播放地址
- (NSURL *) getLocalM3U8Url:(NSURL *)realUrl;

@end









