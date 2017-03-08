//
//  ViewController.m
//  写日历之前先写一个无限循环
//
//  Created by 3D on 17/3/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "CalendarView.h"
#import "NSCalendarManager.h"
@interface ViewController ()
<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) CalendarView *leftCalendarView;
@property(nonatomic,strong) CalendarView *centCalendarView;
@property(nonatomic,strong) CalendarView *rightCalendarView;

@property(nonatomic,strong) NSCalendarManager *calendarManager;
@property(nonatomic,strong) UILabel *timeLb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 30)];
    timeLb.backgroundColor = [UIColor orangeColor];
    self.timeLb = timeLb;
    [self.view addSubview:timeLb];
    
    
    self.calendarManager = [NSCalendarManager sharedInstance];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_WIDTH);
    _scrollView.backgroundColor = [UIColor brownColor];
    _scrollView.delegate = self;
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollView];
    
    
    
    _centCalendarView=[[CalendarView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_scrollView addSubview:_centCalendarView];
    [self.centCalendarView bingModel:self.calendarManager.currentMessage];
    
    
    
    _leftCalendarView=[[CalendarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_scrollView addSubview:_leftCalendarView];
    [self.leftCalendarView bingModel:self.calendarManager.afterMessage];
    
    
    
    _rightCalendarView = [[CalendarView alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_scrollView addSubview:_rightCalendarView];
    [self.rightCalendarView bingModel:self.calendarManager.beforMessage];
    
    
    
    self.timeLb.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.calendarManager.currentMessage.thisYear,(long)self.calendarManager.currentMessage.thisMonth];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x>SCREEN_WIDTH) { //向左滑动
        NSLog(@"+1");
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        self.calendarManager.afterMessage = self.calendarManager.currentMessage;
        self.calendarManager.currentMessage = self.calendarManager.beforMessage;
        [self.calendarManager getbeforMessage];
        
        
        
        
        [self.centCalendarView bingModel:self.calendarManager.currentMessage];
        [self.leftCalendarView bingModel:self.calendarManager.afterMessage];
        [self.rightCalendarView bingModel:self.calendarManager.beforMessage];
        
    }else if(scrollView.contentOffset.x<SCREEN_WIDTH){ //向右滑动
        NSLog(@"-1");
        
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        self.calendarManager.beforMessage = self.calendarManager.currentMessage;
        self.calendarManager.currentMessage = self.calendarManager.afterMessage;
        [self.calendarManager getafterMessage];
        
        
        [self.centCalendarView bingModel:self.calendarManager.currentMessage];
        [self.leftCalendarView bingModel:self.calendarManager.afterMessage];
        [self.rightCalendarView bingModel:self.calendarManager .beforMessage];
    }
    
    
    
    
    self.timeLb.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.calendarManager.currentMessage.thisYear,(long)self.calendarManager.currentMessage.thisMonth];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
