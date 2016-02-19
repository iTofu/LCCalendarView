//
//  LCCalendarCell.m
//  LCCalendarDemo
//
//  Created by Leo on 16/2/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LCCalendarCell.h"

@interface LCCalendarCell ()

@property (nonatomic, weak) UIImageView *redBgView;

@end

@implementation LCCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat cellR = frame.size.width;
        
        UIImageView *redBgView = [[UIImageView alloc] init];
        redBgView.contentMode = UIViewContentModeScaleAspectFit;
        redBgView.image = [UIImage imageNamed:@"CellRedBg"];
        redBgView.frame = CGRectMake(0, 0, cellR, cellR);
        redBgView.hidden = YES;
        [self.contentView addSubview:redBgView];
        self.redBgView = redBgView;
        
        CGFloat space = 5.0f;
        
        UILabel *dayLabel = [[UILabel alloc] init];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.textColor = [UIColor blackColor];
        dayLabel.frame = CGRectMake(0, 0, cellR, cellR * 0.5f + space);
        dayLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:dayLabel];
        self.dayLabel = dayLabel;
        
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.textColor = [UIColor blackColor];
        statusLabel.frame = CGRectMake(0, cellR * 0.5f, cellR, cellR * 0.5f - space);
        statusLabel.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:statusLabel];
        self.statusLabel = statusLabel;
    }
    return self;
}

- (void)setType:(LCCalendarCellType)type {
    _type = type;
    
    if (type == LCCalendarCellTypeNormal) {
        self.redBgView.hidden = YES;
        self.dayLabel.textColor = [UIColor blackColor];
        self.statusLabel.textColor = [UIColor blackColor];
    } else if (type == LCCalendarCellTypeRed) {
        self.redBgView.hidden = NO;
        self.dayLabel.textColor = [UIColor whiteColor];
        self.statusLabel.textColor = [UIColor whiteColor];
    } else if (type == LCCalendarCellTypeGreen) {
        self.redBgView.hidden = NO;
        self.dayLabel.textColor = [UIColor whiteColor];
        self.statusLabel.textColor = [UIColor whiteColor];
        
        self.redBgView.image = [UIImage imageNamed:@"CellGreenBg"];
    }
}

@end
