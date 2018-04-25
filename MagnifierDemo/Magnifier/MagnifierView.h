//
//  MagnifierView.h
//  QiZhiReader
//
//  Created by 杨勇 on 2017/8/17.
//  Copyright © 2017年 Toprays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagnifierView : UIView
@property (nonatomic,weak) UIView *fatherView;
@property (nonatomic) CGPoint touchPoint;
@end
