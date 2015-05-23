//
//  OKEVeryDayCell.m
//  OpenEyes
//
//  Created by qianfeng on 15-5-11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "OKEVeryDayCell.h"
#import "UIImageView+WebCache.h"
@interface OKEVeryDayCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


@end

@implementation OKEVeryDayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(OKEveryDayModel *)model
{
    _model=model;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverForFeed]];
    
    self.titleLabel.text=_model.title;
    
    NSInteger duration =_model.duration.integerValue;
    self.durationLabel.text=[NSString stringWithFormat:@"%.2d'%.2d\"",duration/60,duration%60];
    self.categoryLabel.text=[NSString stringWithFormat:@"#%@",_model.category];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height-=4;
    [super setFrame:frame];
}

@end
