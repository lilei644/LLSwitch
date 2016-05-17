//
//  LLLeftEyeLayer.h
//  LLSwitch
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LLEyesLayer : CALayer

/**
 *  eye property
 */
@property (nonatomic, assign) CGRect eyeRect;

@property (nonatomic, assign) CGFloat eyeDistance;

@property (nonatomic, strong) UIColor *eyeColor;

@property (nonatomic, assign) BOOL isLiking;

@property (nonatomic, assign) CGFloat mouthOffSet;

@property (nonatomic, assign) CGFloat mouthY;

@end
