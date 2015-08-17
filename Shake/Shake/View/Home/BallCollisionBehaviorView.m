//
//  BallCollisionBehaviorView.m
//  Shake
//
//  Created by aken on 15/7/30.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import "BallCollisionBehaviorView.h"
#import <CoreMotion/CoreMotion.h>
#import "BaseBallView.h"

#define maxBallCount 2

@interface BallCollisionBehaviorView()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;

@property (nonatomic, strong) UIGravityBehavior *gravity;

@property (nonatomic, strong) UIPushBehavior *flickPush;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) NSMutableArray *flickViews;

@property (nonatomic, strong) NSMutableArray *pointsArray;

// ball size
@property (nonatomic, strong) NSArray *ballSizeArray;

// ball image name path
@property (nonatomic, strong) NSArray *ballImageNameArray;

@end

@implementation BallCollisionBehaviorView

- (id)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        
        [self setupUI];
    }
    
    
    return self;
}

- (void)dealloc {
    
    // stop the acceleromete update (important)
    [self.motionManager stopAccelerometerUpdates];
}

- (void)setupUI {
    
    //
    self.ballSizeArray=@[@40,@60,@70,@80,@85,@90,@100,@120,@130,@140];
    
    // these image resources come from local path
    self.ballImageNameArray=@[@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png",@"ball.png"];

    self.flickViews = [NSMutableArray arrayWithArray:self.flickViews];
    self.pointsArray = [[self.flickViews valueForKeyPath:@"center"] mutableCopy];
    
    [self physicsSetup];
    [self startAccelerometer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.animator removeAllBehaviors];
        [self addSomeItems];
        [self randomizeProperties];
        [self addBehaviors];
        
    });
}

/*******************************************************physics ball**************************************************/
- (void)addBehaviors
{
    [self.animator addBehavior:self.collisionBehavior];
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.flickPush];
}

- (void)basicsSetup
{
    
    // make an animator to control collision behavior
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    // init some walls here with collision
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.flickViews];
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;//UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    self.collisionBehavior = collisionBehavior;
    [self.animator addBehavior:collisionBehavior];
    [self setNeedsDisplay];
    
}

- (void)physicsSetup
{
    [self basicsSetup];
    
    // then some gravity
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:self.flickViews];
    self.gravity = gravityBeahvior;
    
    self.flickPush = [[UIPushBehavior alloc] initWithItems:self.flickViews mode:UIPushBehaviorModeInstantaneous];
    [self.animator addBehavior:self.flickPush];
}

- (void)randomizeProperties
{
    [self.flickViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setCenter:[self.pointsArray[idx] CGPointValue] ];
        
        UIDynamicItemBehavior *dynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[obj]];
        [dynamicBehavior setDensity:arc4random()%20/10.0];
        [dynamicBehavior setElasticity:arc4random()%5/10.0 +.5];
        [dynamicBehavior setFriction:arc4random()%20/10.0];
        [dynamicBehavior setResistance:arc4random()%8/10.0];
        [dynamicBehavior addAngularVelocity:arc4random()%20/10.0 forItem:obj];
        
        [self.animator addBehavior:dynamicBehavior];
    }];
    
}

- (void)addSomeItems
{
    for (int i = 0; i < maxBallCount; i++) {
        
        int value = arc4random() % maxBallCount;
        int width=[self.ballSizeArray[value] intValue];
        BaseBallView *ball=[[BaseBallView alloc] initWithFrame:CGRectMake(arc4random()%10/10.0 * 200,
                                                                          10.0,
                                                                          width, width)];
        [ball setBallImage:self.ballImageNameArray[value]];
        [self addSubview:ball];
        
        [self.flickViews addObject:ball];
        [self.collisionBehavior addItem:ball];
        [self.gravity addItem:ball];
        [self.flickPush addItem:ball];
        [self.pointsArray addObject:[NSValue valueWithCGPoint:ball.center]];
    }
}

-(void)startAccelerometer {
    
    // shake
    self.motionManager = [[CMMotionManager alloc] init];
    
    if (self.motionManager.accelerometerAvailable) {
        
        [self.motionManager setDeviceMotionUpdateInterval:1];
        [self.motionManager startDeviceMotionUpdates];
        
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                        withHandler:^(CMGyroData *gyroData, NSError *error) {
                                            
                                            CMAttitude *deviceAttitude = self.motionManager.deviceMotion.attitude;
                                            [self.gravity setGravityDirection:CGVectorMake(deviceAttitude.roll*5,deviceAttitude.pitch*5)];
                                        }];
        
        
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                     
                                                     [self motionMethod:accelerometerData];
                                                     
                                                 }];
    }
    
    
}

-(void)motionMethod:(CMAccelerometerData *)acceleration
{
    if(acceleration.acceleration.y > 0 &&
       acceleration.acceleration.x > 0) {
        
        [self.flickPush setPushDirection:CGVectorMake(acceleration.acceleration.x * 5,
                                                      -acceleration.acceleration.y * 5)];
        [self.flickPush setActive:TRUE];
    }
}

@end
