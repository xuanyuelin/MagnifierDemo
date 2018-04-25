//
//  MagnifierVC.m
//  testTempPrj
//
//  Created by 小二黑挖土 on 2018/4/25.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "MagnifierVC.h"
#import "MagnifierView.h"

@interface MagnifierVC ()

@property (strong,nonatomic) UIImageView *backImg;
@property (strong,nonatomic) UIVisualEffectView *effectView;
@property (strong,nonatomic) MagnifierView *magnifierView;
@property (strong,nonatomic) CAShapeLayer *circleMask;

@end

@implementation MagnifierVC
{
    UIView *shotView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"放大镜";
    [self.view addSubview:self.backImg];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    [self.view addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint pt = [touch locationInView:touch.view];
//    _circleMask = [CAShapeLayer layer];
//    UIBezierPath *outPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
//    UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:pt radius:40.f startAngle:0 endAngle:M_PI*2 clockwise:NO];
//    [outPath appendPath:innerPath];
//    [outPath setUsesEvenOddFillRule:YES];
//    [outPath addClip];
////    [outPath stroke];
////    [outPath fill];
//    _circleMask.path = outPath.CGPath;
//    _circleMask.strokeColor = [UIColor blackColor].CGColor;
//    _circleMask.fillColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
//    [self.backImg.layer addSublayer:_circleMask];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint pt = [touch locationInView:touch.view];
//    UIBezierPath *outPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
//    UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:pt radius:40.f startAngle:0 endAngle:M_PI*2 clockwise:NO];
//    [outPath appendPath:innerPath];
//    [outPath setUsesEvenOddFillRule:YES];
//    [outPath addClip];
////    [outPath stroke];
////    [outPath fill];
//    _circleMask.path = outPath.CGPath;
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if(_circleMask) {
//        [_circleMask removeFromSuperlayer];
//        _circleMask = nil;
//    }
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if(_circleMask) {
//        [_circleMask removeFromSuperlayer];
//        _circleMask = nil;
//    }
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.backImg addSubview:self.effectView];
    shotView = [self.view snapshotViewAfterScreenUpdates:NO];
//    [self.view addSubview:self.magnifierView];
}

- (void)didLongPress:(UILongPressGestureRecognizer *)gesture
{
    CGPoint pt = [gesture locationInView:gesture.view];
    UIGestureRecognizerState state = gesture.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            [self showMagnifier];
            _magnifierView.touchPoint = pt;
        }break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            [self hideMagnifier];
        }break;
        default:
            break;
    }
}

- (void)showMagnifier
{
    if(!_magnifierView) {
        _magnifierView = [MagnifierView new];
        _magnifierView.fatherView = self.view;
        [self.view addSubview:_magnifierView];
    }
}
- (void)hideMagnifier
{
    if(_magnifierView) {
        [_magnifierView removeFromSuperview];
        _magnifierView = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backImg removeFromSuperview];
    [self.view addSubview:shotView];
}

//- (void)clipImg:(UIImage *)image
//{
//    CGContextRef cxt = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(cxt);
//    UIBezierPath *outPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.view.bounds, 100, 100)];
//    UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:40.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    [outPath appendPath:innerPath];
//    [outPath setUsesEvenOddFillRule:YES];
//    [outPath addClip];
//    [image drawInRect:self.view.bounds];
//    CGContextRestoreGState(cxt);
//}

- (UIImageView *)backImg
{
    if(_backImg == nil) {
        _backImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
        UIImage *image = [UIImage imageNamed:@"scenery"];
//        [self clipImg:image];
        _backImg.image = image;
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImg;
}

- (UIVisualEffectView *)effectView
{
    if(_effectView == nil) {
        //添加高斯模糊
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [_effectView setFrame:self.backImg.bounds];
    }
    return _effectView;
}

//- (MagnifierView *)magnifierView
//{
//    if(_magnifierView == nil) {
//        _magnifierView = [MagnifierView new];
//        _magnifierView.fatherView = self.view;
//        [_magnifierView setCenter:self.view.center];
//        [_magnifierView setTouchPoint:self.view.center];
//    }
//    return _magnifierView;
//}

@end
