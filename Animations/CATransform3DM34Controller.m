//
//  CATransform3DM34Controller.m
//  Animations
//
//  Created by YouXianMing on 16/1/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CATransform3DM34Controller.h"
#import "GCD.h"
#import "Math.h"

@interface CATransform3DM34Controller ()

@property (nonatomic, strong) CALayer   *layer;
@property (nonatomic, strong) GCDTimer  *timer;
@property (nonatomic)         BOOL       transformState;

@end

@implementation CATransform3DM34Controller

- (void)setup {

    [super setup];
    
    [self initLayer];
    
    [self timerEvent];
}

- (void)initLayer {

    // Init layer.
    UIImage *image         = [UIImage imageNamed:@"1"];
    self.layer             = [CALayer layer];
    self.layer.frame       = CGRectMake(0, 0, image.size.width / 2.f, image.size.height / 2.f);
    self.layer.position    = self.view.center;
    self.layer.borderWidth = 4.f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.contents    = (__bridge id)image.CGImage;
    [self.view.layer addSublayer:self.layer];
}

- (void)timerEvent {

    // Timer event.
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        if (self.transformState == NO) {
            
            self.transformState = YES;
            [self transformStateEvent];
            
        } else {
            
            self.transformState = NO;
            [self normalStateEvent];
        }
        
    } timeIntervalWithSecs:3.f delaySecs:3.f];
    [self.timer start];
}

- (void)transformStateEvent {

    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 30, -35, 0);
    
    // 空间旋转
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:30], 0.75, 1, -0.5);
    
    // 缩放变换
    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
    
    self.layer.transform = perspectiveTransform;
    self.layer.speed     = 0.5;
}

- (void)normalStateEvent {

    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    self.layer.transform = perspectiveTransform;
    self.layer.speed     = 0.5;
}

@end