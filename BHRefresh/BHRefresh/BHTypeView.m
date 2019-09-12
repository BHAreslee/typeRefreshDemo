//
//  BHssssView.m
//  BHRefresh
//
//  Created by sp on 2019/9/12.
//  Copyright © 2019 sp. All rights reserved.
//

#import "BHTypeView.h"


@interface BHTypeView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSMutableArray *viewArray;

@property (nonatomic , strong) UIPanGestureRecognizer *panGestureRecognizer;//Pan手势识别器
@property (nonatomic, assign) CGPoint panStartPoint;//记录触摸起始点



@end

@implementation BHTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.viewArray = [NSMutableArray array];
        
        CGFloat width = frame.size.width/5;
        for (int i = 0; i < 5; i++) {
            UIView *oneView = [[UIView alloc]init];
            
            oneView.tag = 100 + i;
            
            oneView.frame = CGRectMake(i*width, 0, width, frame.size.height);
            
            int g = i % 2;
            if (g == 1) {
                oneView.backgroundColor = [UIColor redColor];
            }else{
                oneView.backgroundColor = [UIColor blueColor];
            }
            [self addSubview:oneView];
            
            UILabel *label = [[UILabel alloc]init];
            
            label.text = [NSString stringWithFormat:@"类型%d",i];
            
            label.textColor = [UIColor blackColor];
            
            [oneView addSubview:label];
            
            label.frame = CGRectMake(0, 0, 60, 40);
            
            [self.viewArray addObject:oneView];
        }
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    CGPoint convertPoint = [self convertPoint:point fromView:touch.view];
    
    UIView *view = touch.view;
    
    NSLog(@"tag ===== %zd",view.tag);
    
    self.type = (int)[self.viewArray indexOfObject:view];
    
    NSLog(@"%@",NSStringFromCGPoint(convertPoint));
}

-(void)panGestureRecognize:(UIPanGestureRecognizer *)recognize{
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognize translationInView:self];
            NSLog(@"-----Current State: Began-----");
            NSLog(@"start point (%f, %f) in View", self.panStartPoint.x, self.panStartPoint.y);
            break;
            
        case UIGestureRecognizerStateChanged:
//            NSLog(@"-----Current State: Changed-----");
//            CGPoint currentPoint = [recognize translationInView:self];
//            NSLog(@"current point (%f, %f) in View", currentPoint.x, currentPoint.y);
            break;
            
        case UIGestureRecognizerStateEnded:
//            NSLog(@"-----Current State: Ended-----");
//            CGPoint endPoint = [recognize translationInView:self];
//            NSLog(@"end point (%f, %f) in View", endPoint.x, endPoint.y);
            break;
            
        case UIGestureRecognizerStateCancelled:
//            NSLog(@"-----Current State: Cancelled-----");
//            NSLog(@"Touch was cancelled");
            break;
            
        case UIGestureRecognizerStateFailed:
//            NSLog(@"-----Current State: Failed-----");
//            NSLog(@"Failed events");
            break;
        default:
            break;
    }
}

-(void)sigleTappedPickerView:(UIGestureRecognizer *)sender{
    
    //取得所点击的点的坐标
    CGPoint point = [sender locationInView:self];
    
    NSLog(@"%f---%f",point.x,point.y);
    
    // 判断该点在不在区域内
    
    for (UIView *view in self.viewArray) {
        if (CGRectContainsPoint(view.frame, point)) {
            NSLog(@"第%zd个",[self.viewArray indexOfObject:view]);
            break;
        }
    }
    
    
    //        if (CGRectContainsPoint(CGRectMake(0)
    
}


+(instancetype)typeViewWithFrame:(CGRect)frame{
    
    return [[BHTypeView alloc]initWithFrame:frame];
    
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
