//
//  LLSwitch.h
//  LLSwitch
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLSwitchDelegate;

IB_DESIGNABLE @interface LLSwitch : UIView


/**
 *  switch on color
 */
@property (nonatomic, strong) IBInspectable UIColor *onColor;

/**
 *  switch off color
 */
@property (nonatomic, strong) IBInspectable UIColor *offColor;

/**
 *  face on and off color
 */
@property (nonatomic, strong) IBInspectable UIColor *faceColor;

/**
 *  the duration is the face moving time
 */
@property (nonatomic, assign) IBInspectable CGFloat animationDuration;


/**
 *  the switch status is or isn't on
 */
@property (nonatomic, assign) IBInspectable BOOL on;

@property (nonatomic, weak) IBOutlet id <LLSwitchDelegate> delegate;

@end


#pragma mark LLSwitch delegate
@protocol LLSwitchDelegate <NSObject>

@optional


- (void)didTapLLSwitch:(LLSwitch *)llSwitch;


- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch;

@end
