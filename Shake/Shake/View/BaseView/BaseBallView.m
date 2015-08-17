//
//  BaseBallView.m
//  Shake
//
//  Created by aken on 15/7/20.
//  Copyright (c) 2015年 Shake. All rights reserved.
//

#import "BaseBallView.h"

@interface BaseBallView()
{
    BOOL isDragging;
}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BaseBallView


-(id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]){

        self.isDragable = NO;
        isDragging = NO;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // ball image
    _imageView=[[UIImageView alloc] init];
    _imageView.frame=self.bounds;
    _imageView.userInteractionEnabled=YES;
    
    [self addSubview:_imageView];
}


- (void)setBallImage:(NSString*)imagePath {
    _imageView.image=[UIImage imageNamed:imagePath];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.isDragable)
        return;
    isDragging = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.isDragable)
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:[self superview]];
    [self setFrame:CGRectMake(currentTouch.x, currentTouch.y, self.frame.size.width, self.frame.size.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event{
    
    if(!self.isDragable)
        return;
    isDragging = NO;
}

@end
