//
//  LLAnimationManager.m
//  LLSwitch
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import "LLAnimationManager.h"
#import <QuartzCore/QuartzCore.h> 

@interface LLAnimationManager()

/**
 *  the duration is the face moving time not include spring animation
 */
@property (nonatomic, assign) CGFloat animationDuration;

@end



@implementation LLAnimationManager


/**
 *  init
 */
- (instancetype)initWithAnimationDuration:(CGFloat)animationDuration {
    self = [super init];
    if (self) {
        _animationDuration = animationDuration;
    }
    return self;
}

/**
 *  faceLayer move animation
 */
- (CABasicAnimation *)moveAnimationWithFromPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
    moveAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.duration = _animationDuration * 2 /3;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    return moveAnimation;
}

/**
 *  layer background color animation
 */
- (CABasicAnimation *)backgroundColorAnimationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnimation.fromValue = fromValue;
    colorAnimation.toValue = toValue;
    colorAnimation.duration = _animationDuration * 2 /3;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fillMode = kCAFillModeForwards;
    return colorAnimation;

}

/**
 * the eyes layer move
 */
- (CABasicAnimation *)eyeMoveAnimationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    moveAnimation.fromValue = fromValue;
    moveAnimation.toValue = toValue;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.duration = _animationDuration / 3;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    return moveAnimation;
}


/**
 * mouth key frame animation
 */
- (CAKeyframeAnimation *)mouthKeyFrameAnimationWidthOffSet:(CGFloat)offSet on:(BOOL)on{
    CGFloat frameNumber = _animationDuration * 60 / 3;
    CGFloat frameValue = on ? offSet : 0;
    NSMutableArray *arrayFrame = [NSMutableArray array];
    for (int i = 0; i < frameNumber; i++) {
        if (on) {
            frameValue = frameValue - offSet / frameNumber;
        } else {
            frameValue = frameValue + offSet / frameNumber;
        }
        [arrayFrame addObject:@(frameValue)];
    }
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"mouthOffSet"];
    keyAnimation.values = arrayFrame;
    keyAnimation.duration = _animationDuration / 4;
    if (!on && _animationDuration >= 1.f) {
        keyAnimation.beginTime = CACurrentMediaTime() + _animationDuration / 12;
    }
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    return keyAnimation;
}

/**
 *  eyes close and open key frame animation
 */
- (CAKeyframeAnimation *)eyesCloseAndOpenAnimationWithRect:(CGRect)rect {
    CGFloat frameNumber = _animationDuration * 180 / 9;         // 180 frame erver second
    CGFloat eyesX = rect.origin.x;
    CGFloat eyesY = rect.origin.y;
    CGFloat eyesWidth = rect.size.width;
    CGFloat eyesHeight = rect.size.height;
    NSMutableArray *arrayFrame = [NSMutableArray array];
    for (int i = 0; i < frameNumber; i++) {
        if (i < frameNumber / 3) {
            // close
            eyesHeight = eyesHeight - rect.size.height / (frameNumber / 3);
        } else if (i >= frameNumber / 3 && i < frameNumber * 2 / 3) {
            // zero
            eyesHeight = 0;
        } else {
            // open
            eyesHeight = eyesHeight + rect.size.height / (frameNumber / 3);
        }
        eyesY = (rect.size.height - eyesHeight) / 2;
        [arrayFrame addObject:[NSValue valueWithCGRect:CGRectMake(eyesX, eyesY, eyesWidth, eyesHeight)]];
    }
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"eyeRect"];
    keyAnimation.values = arrayFrame;
    keyAnimation.duration = _animationDuration / 3;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    return keyAnimation;
}

@end
