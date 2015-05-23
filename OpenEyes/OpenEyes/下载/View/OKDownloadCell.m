//
//  OKDownloadCell.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-23.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKDownloadCell.h"
#import "UIImageView+WebCache.h"
@interface OKDownloadCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;


@end

@implementation OKDownloadCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProgress:(float)progress
{
    _progress=progress;
    
    CGRect coverFrame =self.coverView.frame;
    coverFrame.origin.x=_progress*SCREEN_WIDTH;
    self.coverView.frame=coverFrame;
}

-(void)setTitle:(NSString *)title
{
    _title=[title copy];
    self.titleLabel.text=_title;
}

-(void)setBgImageUrl:(NSString *)bgImageUrl
{
    _bgImageUrl=[bgImageUrl copy];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:_bgImageUrl]];
}

@end
