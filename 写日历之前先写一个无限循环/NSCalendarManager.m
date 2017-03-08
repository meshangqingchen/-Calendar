//
//  NSCalendarManager.m
//  写日历之前先写一个无限循环
//
//  Created by 3D on 17/3/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "NSCalendarManager.h"

@implementation Calendarmessage

@end

static NSCalendarManager *_calendarManager;

@interface NSCalendarManager ()
@property (nonatomic,strong) NSDateComponents *comps;
@property(nonatomic,strong)  NSCalendar *calendar;
@end


@implementation NSCalendarManager

+ (instancetype)sharedInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _calendarManager = [[self alloc] init];
        
    });
    return _calendarManager;
}
- (instancetype)init{
    if (self = [super init]) {
        self.calendar = [NSCalendar currentCalendar];
        self.comps =  [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |kCFCalendarUnitHour |NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal |NSCalendarUnitQuarter|NSCalendarUnitWeekOfMonth) fromDate:[NSDate date]];
        
        [self getcurrentMessage];
        [self getbeforMessage];
        [self getafterMessage];
        
    }
    return self;
}


#pragma mark - 获取当前月总天数NSInteger
- (NSInteger)getTotalDaysThisMonth:(NSDate *)date{
    
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
//    NSLog(@"=======%@",NSStringFromRange(range));
    return range.length;
}
#pragma mark - 判断给定日期是周几
//返回1--周一，7--周日
- (NSInteger)getWeekdayWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSDate *date = [self.calendar dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [self.calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSInteger weekDayNum =[weekdayComponents weekday]-1;
    if (weekDayNum == 0) {
        weekDayNum = 7;
    }
    return weekDayNum;
}

- (void)getcurrentMessage{
    self.currentMessage = [Calendarmessage new];
    
    self.currentMessage.thisYear = [self.comps year];
    self.currentMessage.thisMonth = [self.comps month];
    self.currentMessage.thisMonthDayNum = [self getTotalDaysThisMonth:[NSDate date]];
    self.currentMessage.thisWeekFirstDay = [self getWeekdayWithYear:self.currentMessage.thisYear month:self.currentMessage.thisMonth day:1];
}

- (void)getbeforMessage{
    self.beforMessage = [Calendarmessage new];
    
    if (self.currentMessage.thisMonth == 12) {
        self.beforMessage.thisMonth = 1;
        self.beforMessage.thisYear = self.currentMessage.thisYear+1;

    }else{
        self.beforMessage.thisMonth = self.currentMessage.thisMonth+1;
        self.beforMessage.thisYear = self.currentMessage.thisYear;
    }
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:self.beforMessage.thisMonth];
    [comps setYear:self.beforMessage.thisYear];
    NSDate *date = [self.calendar dateFromComponents:comps];
    
    self.beforMessage.thisMonthDayNum = [self getTotalDaysThisMonth:date];
    self.beforMessage.thisWeekFirstDay = [self getWeekdayWithYear:self.beforMessage.thisYear month:self.beforMessage.thisMonth day:1];
    
}

- (void)getafterMessage{
    self.afterMessage = [Calendarmessage new];
    
    if (self.currentMessage.thisMonth == 1) {
        self.afterMessage.thisMonth = 12;
        self.afterMessage.thisYear = self.currentMessage.thisYear-1;
        
    }else{
        self.afterMessage.thisMonth = self.currentMessage.thisMonth-1;
        self.afterMessage.thisYear = self.currentMessage.thisYear;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:self.afterMessage.thisMonth];
    [comps setYear:self.afterMessage.thisYear];
    NSDate *date = [self.calendar dateFromComponents:comps];
    
    self.afterMessage.thisMonthDayNum = [self getTotalDaysThisMonth:date];
    self.afterMessage.thisWeekFirstDay = [self getWeekdayWithYear:self.afterMessage.thisYear month:self.afterMessage.thisMonth day:1];
}
@end
