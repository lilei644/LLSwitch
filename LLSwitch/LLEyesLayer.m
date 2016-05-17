
//
//  LLLeftEyeLayer.m
//  LLSwitch
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import "LLEyesLayer.h"

@implementation LLEyesLayer

/**
 *  init layer
 *
 *  @return self
 */
- (instancetype)init {
    if (self = [super init]) {
        // 默认属性
        _eyeRect = CGRectMake(0, 0, 0, 0);
        _mouthOffSet = 0.f;
    }
    return self;
}

- (instancetype)initWithLayer:(LLEyesLayer *)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.eyeRect = layer.eyeRect;
        self.eyeDistance = layer.eyeDistance;
        self.eyeColor = layer.eyeColor;
        self.isLiking = layer.isLiking;
        self.mouthOffSet = layer.mouthOffSet;
        self.mouthY = layer.mouthY;
    }
    return self;
}

/**
 *  draw
 */
- (void)drawInContext:(CGContextRef)ctx {
    UIBezierPath *bezierLeft = [UIBezierPath bezierPathWithOvalInRect:_eyeRect];
    UIBezierPath *bezierRight = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_eyeDistance, _eyeRect.origin.y, _eyeRect.size.width, _eyeRect.size.height)];
    
    
    UIBezierPath *bezierMouth = [UIBezierPath bezierPath];
    CGFloat mouthWidth = _eyeRect.size.width + _eyeDistance;
    if (_isLiking) {
        // funny mouth
        [bezierMouth moveToPoint:CGPointMake(0, _mouthY)];
        [bezierMouth addCurveToPoint:CGPointMake(mouthWidth, _mouthY) controlPoint1:CGPointMake(mouthWidth - _mouthOffSet * 3 / 4, _mouthY + _mouthOffSet / 2) controlPoint2:CGPointMake(mouthWidth - _mouthOffSet / 4, _mouthY + _mouthOffSet / 2)];
    } else {
        // boring mouth
        bezierMouth = [UIBezierPath bezierPathWithRect:CGRectMake(0, _mouthY, mouthWidth, _eyeRect.size.height / 4)];
    }

    [bezierMouth closePath];
    CGContextAddPath(ctx, bezierLeft.CGPath);
    CGContextAddPath(ctx, bezierRight.CGPath);
    CGContextAddPath(ctx, bezierMouth.CGPath);
    CGContextSetFillColorWithColor(ctx, _eyeColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
}


/**
 * key animation
 */
+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqual:@"mouthOffSet"]) {
        return YES;
    }
    if ([key isEqual:@"eyeRect"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end
