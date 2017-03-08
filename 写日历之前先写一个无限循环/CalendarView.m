//
//  CalendarView.m
//  写日历之前先写一个无限循环
//
//  Created by 3D on 17/3/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "CalendarView.h"
#import "NSCalendarManager.h"
#define ITEM_WIDTH (([UIScreen mainScreen].bounds.size.width)/7)
#define ITEM_HEIGHT ITEM_WIDTH

@interface CalendarView ()
@property(nonatomic,strong) NSMutableArray *lbarr;
@end

@implementation CalendarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lbarr = [NSMutableArray array];
        [self setUpViews];
        
    }
    return self;
}

-(void)setUpViews{
    NSArray *week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i<week.count; i++) {
        UILabel *lb = [UILabel new];
        lb.text = week[i];
        lb.textColor = [UIColor greenColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.frame = CGRectMake(i*ITEM_WIDTH, 0, ITEM_WIDTH, 40);
        [self addSubview:lb];
    }
    
    for (int i = 0; i<42; i++) {
        UILabel *lb = [UILabel new];
        lb.frame = CGRectMake((i%7)*ITEM_WIDTH, (i/7)*ITEM_HEIGHT+40, ITEM_WIDTH, ITEM_HEIGHT);
        lb.layer.borderWidth = 1;
        lb.layer.borderColor = [UIColor purpleColor].CGColor;
        [self.lbarr addObject:lb];
        lb.tag = i;
        [self addSubview:lb];
    }
}

-(void)bingModel:(Calendarmessage *)model{
    
    for (int i=0; i<self.lbarr.count; i++) {
        UILabel *lb = self.lbarr[i];
        lb.hidden = YES;
        //这样效率不高 可以优化.
    }
    
    if (model.thisWeekFirstDay == 7) {
        model.thisWeekFirstDay = 0;
    }
    
    NSArray *subarr = [self.lbarr subarrayWithRange:NSMakeRange(model.thisWeekFirstDay, model.thisMonthDayNum)];
    
    for (int i = 0; i<subarr.count; i++) {
        UILabel *lb = subarr[i];
        lb.hidden = NO;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = [NSString stringWithFormat:@"%d",i+1];
    }
}
@end
