//
//  NSKKeyboardTypingSymbolView.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/20.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKKeyboardTypingSymbolView.h"

@interface NSKKeyboardTypingSymbolView ()

@property (nonatomic, strong) NSMutableArray<UIView *> *subViews;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UILabel *> *> *subLabels;
@property (nonatomic, strong) NSMutableArray<NSString *> *randomSymbols;

@end

@implementation NSKKeyboardTypingSymbolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self generateRandomSymbols];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect parentFrame = self.bounds;
    NSUInteger viewCount = _subViews.count;
    CGFloat viewWidth = CGRectGetWidth(parentFrame);
    CGFloat viewHeight = (CGRectGetHeight(parentFrame) - (viewCount - 1) * kItemSpacing) / viewCount;

    for (int i = 0; i < 3; i++) {
        UIView *view = [_subViews objectAtIndex:i];
        view.frame = CGRectMake(0, (viewHeight + kItemSpacing) * i, viewWidth, viewHeight);
        CGRect viewFrame = view.bounds;
        NSArray<UILabel *> *labels = [_subLabels objectAtIndex:i];
        viewCount = labels.count;
        CGFloat labelWidth = (CGRectGetWidth(viewFrame) - (viewCount - 1) * kItemSpacing) / viewCount;
        CGFloat labelHeight = CGRectGetHeight(viewFrame);
        for (int j = 0; j < viewCount; j++) {
            UILabel *label = [labels objectAtIndex:j];
            label.frame = CGRectMake((labelWidth + kItemSpacing) * j, 0, labelWidth, labelHeight);
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCharacter:)];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:recognizer];
        }
    }

    UIView *view = [_subViews objectAtIndex:3];
    view.frame = CGRectMake(0, (viewHeight + kItemSpacing) * 3, viewWidth, viewHeight);
    CGRect viewFrame = view.bounds;
    NSArray<UILabel *> *labels = [_subLabels objectAtIndex:3];
    viewCount = labels.count;
    CGFloat labelWidth = (CGRectGetWidth(viewFrame) - 9 * kItemSpacing) / 10;
    CGFloat labelHeight = CGRectGetHeight(viewFrame);
    for (int i = 0; i < viewCount; i++) {
        UILabel *label = [labels objectAtIndex:i];
        if (i == 2) {
            label.frame = CGRectMake((labelWidth + kItemSpacing) * i, 0, (labelWidth + kItemSpacing) * 6 - kItemSpacing, labelHeight);
            [label setText:@"空格"];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSpace:)];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:recognizer];
        } else if (i == 3) {
            label.frame = CGRectMake(CGRectGetWidth(viewFrame) - (labelWidth + kItemSpacing) * 2 + kItemSpacing, 0, (labelWidth + kItemSpacing) * 2 - kItemSpacing, labelHeight);
            [label setText:@"删除"];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDelete:)];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:recognizer];
        } else {
            label.frame = CGRectMake((labelWidth + kItemSpacing) * i, 0, labelWidth, labelHeight);
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCharacter:)];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:recognizer];
        }
    }

    [self fillRandomCharacters];
}

#pragma mark - Click events

- (void)clickCharacter:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(typeACharacter:)]) {
        UILabel *label = (UILabel *) recognizer.view;
        [self.delegate typeACharacter:label.text];
    }
}

- (void)clickDelete:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(typeDelete)]) {
        [self.delegate typeDelete];
    }
}

- (void)clickSpace:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(typeACharacter:)]) {
        [self.delegate typeACharacter:@" "];
    }
}

#pragma mark - Private methods

- (void)setupView {
    if (_subViews) {
        return;
    }

    _subViews = [NSMutableArray array];
    _subLabels = [NSMutableArray array];

    UIView *view1 = [UIView new];
    [self addSubview:view1];
    NSMutableArray<UILabel *> *line1 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UILabel *label = [self generateLabel];
        [line1 addObject:label];
        [view1 addSubview:label];
    }
    [_subViews addObject:view1];
    [_subLabels addObject:line1];

    UIView *view2 = [UIView new];
    [self addSubview:view2];
    NSMutableArray<UILabel *> *line2 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UILabel *label = [self generateLabel];
        [line2 addObject:label];
        [view2 addSubview:label];
    }
    [_subViews addObject:view2];
    [_subLabels addObject:line2];

    UIView *view3 = [UIView new];
    [self addSubview:view3];
    NSMutableArray<UILabel *> *line3 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UILabel *label = [self generateLabel];
        [line3 addObject:label];
        [view3 addSubview:label];
    }
    [_subViews addObject:view3];
    [_subLabels addObject:line3];

    UIView *view4 = [UIView new];
    [self addSubview:view4];
    NSMutableArray<UILabel *> *line4 = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UILabel *label = [self generateLabel];
        [line4 addObject:label];
        [view4 addSubview:label];
    }
    [_subViews addObject:view4];
    [_subLabels addObject:line4];
}

- (UILabel *)generateLabel {
    UILabel *label = [UILabel new];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}

- (void)generateRandomSymbols {
    _randomSymbols = [NSMutableArray arrayWithCapacity:32];
    NSMutableArray *startArray = [NSMutableArray array];
    for (int i = 33; i <= 47; i++) {
        [startArray addObject:[NSString stringWithFormat:@"%c", i]];
    }
    for (int i = 58; i <= 64; i++) {
        [startArray addObject:[NSString stringWithFormat:@"%c", i]];
    }
    for (int i = 91; i <= 96; i++) {
        [startArray addObject:[NSString stringWithFormat:@"%c", i]];
    }
    for (int i = 123; i <= 126; i++) {
        [startArray addObject:[NSString stringWithFormat:@"%c", i]];
    }
    NSUInteger round = startArray.count;
    for (int i = 0; i < round; i++) {
        int rndIndex = arc4random() % startArray.count;
        _randomSymbols[i] = startArray[rndIndex];
        startArray[rndIndex] = [startArray lastObject];
        [startArray removeLastObject];
    }
}

- (void)fillRandomCharacters {
    for (int i = 0; i < _subLabels.count; i++) {
        NSMutableArray<UILabel *> *labels = [_subLabels objectAtIndex:i];
        for (int j = 0; j < labels.count; j++) {
            if (_randomSymbols.count == 0) {
                break;
            }
            NSString *character = _randomSymbols.lastObject;
            [_randomSymbols removeLastObject];
            [[labels objectAtIndex:j] setText:character];
        }
    }
}

@end
