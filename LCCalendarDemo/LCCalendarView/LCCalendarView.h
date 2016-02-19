//
//  LCCalendarView.h
//  LCCalendarDemo
//
//  Created by Leo on 16/2/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCCalendarView;


@protocol LCCalendarViewDelegate <NSObject>

@optional

- (void)calendarView:(LCCalendarView *)calendarView didSelectedDateString:(NSString *)dateString;

@end


@interface LCCalendarView : UIView

/**
 *  日期字符串 年月 如：`201602`
 */
@property (nonatomic, copy) NSString *dateStringYM;

@property (nonatomic, weak) id<LCCalendarViewDelegate> delegate;

@end
