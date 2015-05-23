//
//  OKEveryDayModel.h
//  OpenEyes
//
//  Created by qianfeng on 15-5-11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKEveryDayModel : NSObject

@property (nonatomic,strong) NSNumber * id;// : 1022
@property (nonatomic,strong) NSNumber * date;// : 1431273600000
@property (nonatomic,strong) NSNumber * idx;// : 1
@property (nonatomic,copy) NSString * title;// : "混剪：Brain Farm"
@property (nonatomic,copy) NSString * desc;// : "导演 Curt Morgan 最新的 Brain Farm 作品集锦，给周一带来心旷神怡的活力。生活就是要上天下地瞎折腾，别打盹了，起来嗨！From BrainFarm"
@property (nonatomic,copy) NSString * category;// : "运动"
// provider
@property (nonatomic,strong) NSNumber * duration;// : 244
@property (nonatomic,copy) NSString * coverForFeed;// : "http://img.wdjimg.com/image/video/93306640c11344e0729fdfbea0798eb1_0_0.jpeg"
@property (nonatomic,copy) NSString * coverForDetail;// : "http://img.wdjimg.com/image/video/93306640c11344e0729fdfbea0798eb1_0_0.jpeg"
@property (nonatomic,copy) NSString * coverBlurred;// : "http://img.wdjimg.com/image/video/f79b11703c73eb5e242972077afe6958_0_0.jpeg"
@property (nonatomic,copy) NSString * playUrl;// : "http://baobab.cdn.wandoujia.com/143115394501001sport.mp4"
@property (nonatomic,copy) NSString * webUrl;// : "http://wandou.im/jzqzr"
@property (nonatomic,copy) NSString * rawWebUrl;// : "http://www.wandoujia.com/ios/eyepetizer/detail.html?vid=1022"

@end
