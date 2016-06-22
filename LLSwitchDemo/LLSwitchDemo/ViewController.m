//
//  ViewController.m
//  LLSwitchDemo
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import "ViewController.h"
#import "LLSwitch.h"

@interface ViewController () <LLSwitchDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LLSwitch *llSwitch = [[LLSwitch alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
    [self.view addSubview:llSwitch];
    llSwitch.delegate = self;
}

-(void)didTapLLSwitch:(LLSwitch *)llSwitch {
    NSLog(@"start");
}

- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch {
    NSLog(@"stop");
}

- (void)valueDidChanged:(LLSwitch *)llSwitch on:(BOOL)on {
    NSLog(@"stop --- on:%hhd", on);
}

@end
