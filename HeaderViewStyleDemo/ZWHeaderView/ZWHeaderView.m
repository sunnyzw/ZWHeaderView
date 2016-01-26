//
//  ZWHeaderView.m
//  下拉放大
//
//  Created by SmartDoc on 16/1/11.
//  Copyright © 2016年 SmartDoc. All rights reserved.
//

#import "ZWHeaderView.h"

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;
static CGFloat kMaxTitleAlphaOffset = 100.0f;
static CGFloat kLabelPaddingDist = 8.0f;

@interface ZWHeaderView ()

@property (nonatomic,strong) UIScrollView * imgScroll;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UIImage * headerImg;
@property (nonatomic,strong) UIViewController * ctrl;

@end

@implementation ZWHeaderView

- (instancetype)initWithFrame:(CGRect)frame headerImg:(NSString *)imgStr controller:(UIViewController *)ctrl {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * headerImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.headerImg = [UIImage imageNamed:imgStr];
        [self initialHeader];
        [self addSubview:headerImgView];
        
        _ctrl = ctrl;
        [_ctrl.navigationController.navigationBar zw_setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// 初始化header
- (void)initialHeader {
    self.imgScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imgView = [[UIImageView alloc] initWithFrame:self.imgScroll.bounds];
    self.imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.image = self.headerImg;
    [self.imgScroll addSubview:self.imgView];
    [self addSubview:self.imgScroll];
    
    CGRect labelRect = self.imgScroll.bounds;
    labelRect.origin.x = labelRect.origin.y = kLabelPaddingDist;
    labelRect.size.width = labelRect.size.width - 2 * kLabelPaddingDist;
    labelRect.size.height = labelRect.size.height - 2 * kLabelPaddingDist;
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:labelRect];
    self.headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.headerTitleLabel.numberOfLines = 0;
    self.headerTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.headerTitleLabel.autoresizingMask = self.imgView.autoresizingMask;
    self.headerTitleLabel.textColor = [UIColor whiteColor];
    self.headerTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.imgScroll addSubview:self.headerTitleLabel];
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset {
    CGRect frame = self.imgScroll.frame;
    if (offset.y > 0) {
        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        self.imgScroll.frame = frame;
        self.clipsToBounds = YES;
        
    } else {
        // 向下拉
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imgScroll.frame = rect;
        self.clipsToBounds = NO;
        self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset;
    }
}

- (void)setNavigationBarAlphaWithOffsetY:(CGFloat)offsetY {
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    if (offsetY > self.frame.size.height-128) {
        CGFloat alpha = MIN(1, 1 - ((self.frame.size.height - 64 - offsetY) / 64));
        [_ctrl.navigationController.navigationBar zw_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [_ctrl.navigationController.navigationBar zw_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}


@end
