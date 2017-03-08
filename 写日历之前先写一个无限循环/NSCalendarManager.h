//
//  NSCalendarManager.h
//  写日历之前先写一个无限循环
//
//  Created by 3D on 17/3/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendarmessage : NSObject
@property (nonatomic,assign)  NSInteger currentDay;        //当前是几号
@property (nonatomic,assign) NSInteger thisMonthDayNum;    //当前月有多少天
@property (nonatomic,assign) NSInteger thisYear;           //当前的年份
@property (nonatomic,assign) NSInteger thisMonth;          //当前的月份
@property (nonatomic,assign) NSInteger thisWeekFirstDay;   //当前一号是周几

@end

@interface NSCalendarManager : NSObject


@property (nonatomic,strong)  Calendarmessage *currentMessage;
@property (nonatomic,strong)  Calendarmessage *beforMessage;
@property (nonatomic,strong)  Calendarmessage *afterMessage;

+ (instancetype)sharedInstance;

- (void)getcurrentMessage;
- (void)getbeforMessage;
- (void)getafterMessage;
@end
