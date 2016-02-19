//
//  LCCalendarCell.h
//  LCCalendarDemo
//
//  Created by Leo on 16/2/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LCCalendarCellTypeNormal,
    LCCalendarCellTypeRed,
    LCCalendarCellTypeGreen,
} LCCalendarCellType;

@interface LCCalendarCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, weak) UILabel *statusLabel;

@property (nonatomic, assign) LCCalendarCellType type;

@end
