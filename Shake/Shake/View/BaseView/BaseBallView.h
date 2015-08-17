//
//  BaseBallView.h
//  Shake
//
//  base ball view
//  Created by aken on 15/7/20.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseBallView : UIView

@property (nonatomic, assign) CGFloat velocityX;

@property (nonatomic, assign) CGFloat velocityY;

@property (readwrite) BOOL isDragable;

- (void)setBallImage:(NSString*)imagePath;

@end
