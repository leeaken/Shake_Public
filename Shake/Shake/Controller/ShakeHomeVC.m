//
//  ShakeHomeVC.m
//  Shake
//
//  Created by aken on 15/7/16.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import "ShakeHomeVC.h"
#import "BaseBallView.h"
#import "ShakeHomeView.h"


@interface ShakeHomeVC ()<UICollisionBehaviorDelegate>
{
    BOOL isShake;
}

// shake home view
@property (nonatomic, strong) ShakeHomeView *shakeHomeView;

// card package
@property (nonatomic, strong) UIButton *cardPackgeButton;

@end

@implementation ShakeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLayout];

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initLayout {
    
    
    self.title=@"shake";
    self.view.backgroundColor=[UIColor whiteColor];
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self.view addSubview:self.shakeHomeView];
    
}


- (ShakeHomeView*)shakeHomeView {
    
    if (_shakeHomeView==nil) {
        
        _shakeHomeView=[[ShakeHomeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    }
    
    return _shakeHomeView;
}


#pragma mark - shake event

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake) {
        
        // User was shaking the device. Post a notification named "shake."
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
        
        
    }
}




@end
