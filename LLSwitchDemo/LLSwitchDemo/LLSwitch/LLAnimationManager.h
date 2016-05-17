//
//  LLAnimationManager.h
//  LLSwitch
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface LLAnimationManager : NSObject


/**
 *  init
 */
- (instancetype)initWithAnimationDuration:(CGFloat)animationDuration;


/**
 * the face layer move position
 */
- (CABasicAnimation *)moveAnimationWithFromPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition;

/**
 * the layer background color animation
 */
- (CABasicAnimation *)backgroundColorAnimationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

/**
 * the eye layer move position
 */
- (CABasicAnimation *)eyeMoveAnimationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

/**
 * mouth key frame animation
 */
- (CAKeyframeAnimation *)mouthKeyFrameAnimationWidthOffSet:(CGFloat)offSet on:(BOOL)on;

/**
 *  eyes close and open key frame animation
 */
- (CAKeyframeAnimation *)eyesCloseAndOpenAnimationWithRect:(CGRect)rect;


@end
