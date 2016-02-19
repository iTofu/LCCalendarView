//
//  ViewController.m
//  LCCalendarDemo
//
//  Created by Leo on 16/2/19.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LCCalendarView.h"

@interface ViewController () <LCCalendarViewDelegate>

@property (nonatomic, weak) LCCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LCCalendarView *calendarView = [[LCCalendarView alloc] init];
    calendarView.dateStringYM = @"201602";
    calendarView.delegate = self;
    calendarView.frame = CGRectMake(0, 64.0f, [UIScreen mainScreen].bounds.size.width, 300.0f);
    [self.view addSubview:calendarView];
    
    
    
    self.title = calendarView.dateStringYM;
}

#pragma mark - LCCalendarViewDelegate

- (void)calendarView:(LCCalendarView *)calendarView didSelectedDateString:(NSString *)dateString {
    
    NSLog(@"Clicked Date: %@", dateString);
}

@end
