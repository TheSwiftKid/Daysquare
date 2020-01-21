//
//  DAYComponentView.m
//  Daysquare
//
//  Created by 杨弘宇 on 16/6/7.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

#import "DAYComponentView.h"

@interface DAYComponentView () <EKEventViewDelegate>

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) CAShapeLayer *dotLayer;

@end

@implementation DAYComponentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.textLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    
    self.dotLayer = [CAShapeLayer layer];
    self.dotLayer.hidden = YES;
    
    [self.layer addSublayer:self.dotLayer];
    
    UITapGestureRecognizer *aRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
    [self addGestureRecognizer:aRecognizer];
    
    UILongPressGestureRecognizer *anotherRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidLongPress:)];
    [self addGestureRecognizer:anotherRecognizer];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.dotLayer.path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, 5, 5), nil);
    self.dotLayer.frame = CGRectMake((CGRectGetWidth(self.frame) - 5) / 2.0, CGRectGetMaxY(self.textLabel.frame), 5, 5);
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.textLabel.textColor = self.highlightTextColor;
        self.dotLayer.fillColor = self.highlightTextColor.CGColor;
    }
    else {
        self.textLabel.textColor = self.textColor;
    }
}

- (void)viewDidTap:(id)sender {
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Event view delegate

- (void)eventViewController:(EKEventViewController *)controller didCompleteWithAction:(EKEventViewAction)action {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
