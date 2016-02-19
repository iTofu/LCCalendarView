//
//  LCCalendarView.m
//  LCCalendarDemo
//
//  Created by Leo on 16/2/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "LCCalendarView.h"
#import "LCWeekdayView.h"
#import "LCCalendarCell.h"

const CGFloat CellSpace = 10.0f;
#define WEEKDAY_TITLES  @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]

@interface LCCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) LCWeekdayView *weekdayView;
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 *  空白 cell 个数
 */
@property (nonatomic, assign) NSInteger whiteCellCount;

/**
 *  当月天数
 */
@property (nonatomic, assign) NSInteger days;

@end

@implementation LCCalendarView

static NSString *CellID = @"me.leodev.LCCalendarCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // weekday view
        LCWeekdayView *weekdayView = [[LCWeekdayView alloc] init];
        [self addSubview:weekdayView];
        self.weekdayView = weekdayView;
        
        for (int i = 0; i < 7; i++) {
            UILabel *weekdayLabel = [[UILabel alloc] init];
            weekdayLabel.font = [UIFont systemFontOfSize:14.0f];
            weekdayLabel.text = WEEKDAY_TITLES[i];
            weekdayLabel.textAlignment = NSTextAlignmentCenter;
            weekdayLabel.textColor = [UIColor colorWithRed:73/255.0f green:183/255.0f blue:252/255.0f alpha:1.0f];
            weekdayLabel.tag = i + 100;
            [weekdayView addSubview:weekdayLabel];
        }
        
        // collection view
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellR = [UIScreen mainScreen].bounds.size.width / 7 - CellSpace;
        flowLayout.itemSize = CGSizeMake(cellR, cellR);
        flowLayout.sectionInset = UIEdgeInsetsMake(CellSpace * 0.5f, CellSpace * 0.5f, CellSpace * 0.5f, CellSpace * 0.5f);
        flowLayout.minimumInteritemSpacing = CellSpace;
        flowLayout.minimumLineSpacing = CellSpace;
        
        CGRect collectionViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        [collectionView registerClass:[LCCalendarCell class] forCellWithReuseIdentifier:CellID];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    
    self.weekdayView.frame = CGRectMake(0, 0, width, 40.0f);
    
    for (UILabel *weekdayLabel in self.weekdayView.subviews) {
        CGFloat w = width / 7;
        CGFloat h = self.weekdayView.frame.size.height;
        CGFloat x = (weekdayLabel.tag - 100) * w;
        weekdayLabel.frame = CGRectMake(x, 0, w, h);
    }
    
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.weekdayView.frame), self.frame.size.width, 300);
}

- (void)setDateStringYM:(NSString *)dateStringYM {
    
    _dateStringYM = [dateStringYM copy];
    
    NSString *firstDay = [NSString stringWithFormat:@"%@01", dateStringYM];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:firstDay];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    self.whiteCellCount = components.weekday - 1;
    
    NSRange daysRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    self.days = daysRange.length;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.days + self.whiteCellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    if (indexPath.row >= self.whiteCellCount) {
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - self.whiteCellCount + 1];
        cell.statusLabel.text = @"正常";
        
        // Flag
        if (indexPath.row % 5 == 0) {
            cell.type = LCCalendarCellTypeRed;
        } else if (indexPath.row % 11 == 0) {
            cell.type = LCCalendarCellTypeGreen;
        } else {
            cell.type = LCCalendarCellTypeNormal;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.whiteCellCount) {
        if ([self.delegate respondsToSelector:@selector(calendarView:didSelectedDateString:)]) {
            NSString *dateString = [NSString stringWithFormat:@"%@%02ld", self.dateStringYM, indexPath.row - self.whiteCellCount + 1];
            [self.delegate calendarView:self didSelectedDateString:dateString];
        }
    }
}

@end
