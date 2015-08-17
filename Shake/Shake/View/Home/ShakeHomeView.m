//
//  ShakeHomeView.m
//  Shake
//
//  Created by aken on 15/7/30.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import "ShakeHomeView.h"
#import "BallCollisionBehaviorView.h"
#import <QuartzCore/QuartzCore.h>


@interface ShakeHomeView()

// ball view
@property (nonatomic, strong) BallCollisionBehaviorView *ballView;

@end

@implementation ShakeHomeView

- (id)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
     
        [self setupUI];
    }
    
    
    return self;
}

- (void)setupUI {

    [self addSubview:self.ballView];

}

#pragma mark - prviate


// some collision balls
- (BallCollisionBehaviorView*)ballView {
    
    if (_ballView==nil) {
        
        _ballView=[[BallCollisionBehaviorView alloc] initWithFrame:self.bounds];
    }
    
    return _ballView;
}

@end
