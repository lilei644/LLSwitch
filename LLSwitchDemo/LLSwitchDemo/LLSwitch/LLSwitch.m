//
//  LLSwitch.m
//  LLSwitch
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 LiLei. All rights reserved.
//

#import "LLSwitch.h"
#import "LLAnimationManager.h"
#import "LLEyesLayer.h"


NSString * const FaceMoveAnimationKey = @"FaceMoveAnimationKey";
NSString * const BackgroundColorAnimationKey = @"BackgroundColorAnimationKey";
NSString * const EyesMoveStartAnimationKey = @"EyesMoveStartAnimationKey";
NSString * const EyesMoveEndAnimationKey = @"EyesMoveEndAnimationKey";
NSString * const EyesMoveBackAnimationKey = @"EyesMoveBackAnimationKey";
NSString * const MouthFrameAnimationKey = @"MouthFrameAnimationKey";
NSString * const EyesCloseAndOpenAnimationKey = @"EyesCloseAndOpenAnimationKey";

@interface LLSwitch()

/**
 *  switch background view
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 *  face layer
 */
@property (nonatomic, strong) CAShapeLayer *circleFaceLayer;

/**
 *  paddingWidth
 */
@property (nonatomic, assign) CGFloat paddingWidth;

/**
 *  eyes layer
 */
@property (nonatomic, strong) LLEyesLayer *eyesLayer;

/**
 *  face radius
 */
@property (nonatomic, assign) CGFloat circleFaceRadius;

/**
 *  the faceLayer move distance
 */
@property (nonatomic, assign) CGFloat moveDistance;

/**
 *  handler layer animation manager
 */
@property (nonatomic, strong) LLAnimationManager *animationManager;


/**
 *  whether is animated
 */
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) CGFloat faceLayerWidth;



@end


@implementation LLSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetUpView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetUpView];
    }
    return self;
}


- (void)initSetUpView {
    
    /**
     *  check the switch width and height
     */
    NSAssert(self.frame.size.width >= self.frame.size.height, @"switch width must be tall！");
    
    /**
     *  init property
     */
    _onColor = [UIColor colorWithRed:73/255.0 green:182/255.0 blue:235/255.0 alpha:1.f];
    _offColor = [UIColor colorWithRed:211/255.0 green:207/255.0 blue:207/255.0 alpha:1.f];
    _faceColor = [UIColor whiteColor];
    _paddingWidth = self.frame.size.height * 0.1;
    _circleFaceRadius = (self.frame.size.height - 2 * _paddingWidth) / 2;
    _animationDuration = 1.2f;
    _animationManager = [[LLAnimationManager alloc] initWithAnimationDuration:_animationDuration];
    _moveDistance = self.frame.size.width - _paddingWidth * 2 - _circleFaceRadius * 2;
    _on = NO;
    _isAnimating = NO;
    
    /**
     *  setting init property
     */
    self.backgroundView.backgroundColor = _offColor;
    self.circleFaceLayer.fillColor = _faceColor.CGColor;
    self.faceLayerWidth = self.circleFaceLayer.frame.size.width;
    [self.eyesLayer setNeedsDisplay];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSwitch)]];
}


#pragma mark set property

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    return;
}

- (void)setOffColor:(UIColor *)offColor {
    _offColor = offColor;
    if (!_on) {
        _backgroundView.backgroundColor = offColor;
        _eyesLayer.eyeColor = offColor;
        [self.eyesLayer setNeedsDisplay];
    }
}

- (void)setOnColor:(UIColor *)onColor {
    _onColor = onColor;
    if (_on) {
        _backgroundView.backgroundColor = onColor;
        _eyesLayer.eyeColor = onColor;
        [self.eyesLayer setNeedsDisplay];
    }
}

- (void)setFaceColor:(UIColor *)faceColor {
    _faceColor = faceColor;
    _circleFaceLayer.fillColor = faceColor.CGColor;
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    _animationManager = [[LLAnimationManager alloc] initWithAnimationDuration:_animationDuration];
}

- (void)setOn:(BOOL)on {
    _on = on;
    if (on) {
        self.backgroundView.backgroundColor = _onColor;
        self.circleFaceLayer.position = CGPointMake(self.circleFaceLayer.position.x + _moveDistance, self.circleFaceLayer.position.y);
        self.eyesLayer.eyeColor = _onColor;
        self.eyesLayer.isLiking = YES;
        self.eyesLayer.mouthOffSet = _eyesLayer.frame.size.width;
        [self.eyesLayer needsDisplay];
    }
}


#pragma mark GestureRecognizer
- (void)handleTapSwitch {
    if (_isAnimating) {
        return;
    }
    _isAnimating = YES;
    // faceLayer
    CABasicAnimation *moveAnimation = [_animationManager moveAnimationWithFromPosition:_circleFaceLayer.position toPosition:_on ? CGPointMake(_circleFaceLayer.position.x - _moveDistance, _circleFaceLayer.position.y) : CGPointMake(_circleFaceLayer.position.x + _moveDistance, _circleFaceLayer.position.y)];
    moveAnimation.delegate = self;
    [_circleFaceLayer addAnimation:moveAnimation forKey:FaceMoveAnimationKey];
    
    // backfroundView
    CABasicAnimation *colorAnimation = [_animationManager backgroundColorAnimationFromValue:(id)(_on ? _onColor : _offColor).CGColor toValue:(id)(_on ? _offColor : _onColor).CGColor];
    [_backgroundView.layer addAnimation:colorAnimation forKey:BackgroundColorAnimationKey];
    
    // eyesLayer
    CABasicAnimation *rotationAnimation = [_animationManager eyeMoveAnimationFromValue:@(0) toValue:@(_on ? -_faceLayerWidth : _faceLayerWidth)];
    rotationAnimation.delegate = self;
    [_eyesLayer addAnimation:rotationAnimation forKey:EyesMoveStartAnimationKey];
    _circleFaceLayer.masksToBounds = YES;
    if (_on) {
        [self eyesKeyFrameAnimationStart];
    }
    
    
    // start delegate
    if ([self.delegate respondsToSelector:@selector(didTapLLSwitch:)]) {
        [self.delegate didTapLLSwitch:self];
    }
    
}



#pragma mark Init

/**
 *  init backgroundView
 *
 *  @return backgroundView
 */
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = self.bounds;
        _backgroundView.layer.cornerRadius = self.frame.size.height / 2;
        _backgroundView.layer.masksToBounds = YES;
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}


/**
 *  init circleFaceLayer
 *
 *  @return circleFaceLayer
 */
- (CAShapeLayer *)circleFaceLayer {
    if (!_circleFaceLayer) {
        _circleFaceLayer = [CAShapeLayer layer];
        [_circleFaceLayer setFrame:CGRectMake(_paddingWidth, _paddingWidth, _circleFaceRadius * 2, _circleFaceRadius *2)];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:_circleFaceLayer.bounds];
        _circleFaceLayer.path = circlePath.CGPath;
        [self.backgroundView.layer addSublayer:_circleFaceLayer];
    }
    return _circleFaceLayer;
}


/**
 *  eyes and mouth layer
 *
 *  @return eyesLayer
 */
- (LLEyesLayer *)eyesLayer {
    if (!_eyesLayer) {
        _eyesLayer = [LLEyesLayer layer];
        _eyesLayer.eyeRect = CGRectMake(0, 0, _faceLayerWidth / 6, _circleFaceLayer.frame.size.height * 0.22);
        _eyesLayer.eyeDistance = _faceLayerWidth / 3;
        _eyesLayer.eyeColor = _offColor;
        _eyesLayer.isLiking = NO;
        _eyesLayer.mouthY = _eyesLayer.eyeRect.size.height * 7 / 4;
        _eyesLayer.frame = CGRectMake(_faceLayerWidth / 4, _circleFaceLayer.frame.size.height * 0.28, _faceLayerWidth / 2, _circleFaceLayer.frame.size.height * 0.72);
    //    _eyesLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.circleFaceLayer addSublayer:_eyesLayer];

    }
    return  _eyesLayer;
}

#pragma mark AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        
        // start eyes ending animation
        if (anim == [_eyesLayer animationForKey:EyesMoveStartAnimationKey]) {
            _eyesLayer.eyeColor = _on ?  _offColor: _onColor;
            _eyesLayer.isLiking = !_on;
            [_eyesLayer setNeedsDisplay];
            CABasicAnimation *rotationAnimation = [_animationManager eyeMoveAnimationFromValue:@(_on ? _faceLayerWidth : -_faceLayerWidth) toValue:@(_on ? -_faceLayerWidth / 6 :  _faceLayerWidth / 6)];
            rotationAnimation.delegate = self;
            [_eyesLayer addAnimation:rotationAnimation forKey:EyesMoveEndAnimationKey];
            
            if (!_on) {
                [self eyesKeyFrameAnimationStart];
            }
        }
        
        // start eyes back animation
        if (anim == [_eyesLayer animationForKey:EyesMoveEndAnimationKey]) {
            CABasicAnimation *rotationAnimation = [_animationManager eyeMoveAnimationFromValue:@(_on ? -_faceLayerWidth / 6 :  _faceLayerWidth / 6) toValue:@(0)];
            rotationAnimation.delegate = self;
            [_eyesLayer addAnimation:rotationAnimation forKey:EyesMoveBackAnimationKey];
            
            if (!_on) {
                CAKeyframeAnimation *eyesKeyFrameAnimation = [_animationManager eyesCloseAndOpenAnimationWithRect:_eyesLayer.eyeRect];
                [_eyesLayer addAnimation:eyesKeyFrameAnimation forKey:EyesCloseAndOpenAnimationKey];
            }
        }
        
        // eyes back animation end
        if (anim == [_eyesLayer animationForKey:EyesMoveBackAnimationKey]) {
            [_eyesLayer removeAllAnimations];
            _eyesLayer.mouthOffSet = _on ? 0 : _eyesLayer.frame.size.width;
            
            if (_on) {
                _circleFaceLayer.position = CGPointMake(_circleFaceLayer.position.x - _moveDistance, _circleFaceLayer.position.y);
                _on = NO;
            } else {
                _circleFaceLayer.position = CGPointMake(_circleFaceLayer.position.x + _moveDistance, _circleFaceLayer.position.y);
                _on = YES;
            }
            _isAnimating = NO;
            
            
            // stop delegate
            if ([self.delegate respondsToSelector:@selector(animationDidStopForLLSwitch:)]) {
                [self.delegate animationDidStopForLLSwitch:self];
            }
        }
    }
}

/**
 *  add mouth keyFrameAnimation
 */
- (void)eyesKeyFrameAnimationStart {
    CAKeyframeAnimation *keyAnimation = [_animationManager mouthKeyFrameAnimationWidthOffSet:_eyesLayer.frame.size.width on:_on];
    [_eyesLayer addAnimation:keyAnimation forKey:MouthFrameAnimationKey];
}

- (void)dealloc {
    self.delegate = nil;
}


@end
