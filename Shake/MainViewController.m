//
//  MainViewController.m
//  Shake
//
//  Created by aken on 15/7/16.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import "MainViewController.h"
#import "ShakeHomeVC.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shakeClick:(id)sender {
    
    
    ShakeHomeVC *homeVC=[[ShakeHomeVC alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

@end
