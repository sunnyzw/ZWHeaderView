//
//  ZWHeaderView.h
//  下拉放大
//
//  Created by SmartDoc on 16/1/11.
//  Copyright © 2016年 SmartDoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+Awesome.h"

@interface ZWHeaderView : UIView

@property (nonatomic,strong) UILabel *headerTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame headerImg:(NSString *)imgStr controller:(UIViewController *)ctrl;

// 根据contentY放大图片
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
// 根据contentY设置导航栏透明度
- (void)setNavigationBarAlphaWithOffsetY:(CGFloat)offsetY;

@end
