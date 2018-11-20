//
//  NSKKeyboardTypingCharacterView.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/19.
//  Copyright © 2018 nationsky. All rights reserved.
//

#import "NSKKeyboardTypingCharacterView.h"

@interface NSKKeyboardTypingCharacterView ()

#define kMargin 10
#define kSpecialKeyWidth 50

@property (nonatomic, strong) NSMutableArray<UIView *> *subViews;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UILabel *> *> *subLabels;
@property (nonatomic, strong) NSMutableArray<NSString *> *randomCharacters;

@property (nonatomic, assign) BOOL isCapital;

@end

@implementation NSKKeyboardTypingCharacterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isCapital = NO;
        [self setupView];
        [self generateRandomCharacters];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect parentFrame = self.bounds;
    NSUInteger viewCount = _subViews.count;
    CGFloat viewWidth = CGRectGetWidth(parentFrame);
    CGFloat viewHeight = (CGRectGetHeight(parentFrame) - (viewCount - 1) * kItemSpacing) / viewCount;

    UIView *view1 = [_subViews objectAtIndex:0];
    view1.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    CGRect viewFrame = view1.bounds;
    NSArray<UILabel *> *labels = [_subLabels objectAtIndex:0];
    viewCount = labels.count;
    CGFloat labelWidth = (CGRectGetWidth(viewFrame) - (viewCount - 1) * kItemSpacing) / viewCount;
    CGFloat labelHeight = CGRectGetHeight(viewFrame);
    for (int i = 0; i < viewCount; i++) {
        UILabel *label = [labels objectAtIndex:i];
        label.frame = CGRectMake((labelWidth + kItemSpacing) * i, 0, labelWidth, labelHeight);
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCharacter:)];
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:recognizer];
    }

    UIView *view2 = [_subViews objectAtIndex:1];
    view2.frame = CGRectMake(kMargin, viewHeight + kItemSpacing, viewWidth - kMargin * 2, viewHeight);
    viewFrame = view2.bounds;
    labels = [_subLabels objectAtIndex:1];
    viewCount = labels.count;
    labelWidth = (CGRectGetWidth(viewFrame) - (viewCount - 1) * kItemSpacing) / viewCount;
    labelHeight = CGRectGetHeight(viewFrame);
    for (int i = 0; i < viewCount; i++) {
        UILabel *label = [labels objectAtIndex:i];
        label.frame = CGRectMake((labelWidth + kItemSpacing) * i, 0, labelWidth, labelHeight);
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCharacter:)];
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:recognizer];
    }

    UIView *view3 = [_subViews objectAtIndex:2];
    view3.frame = CGRectMake(0, (viewHeight + kItemSpacing) * 2, viewWidth, viewHeight);
    viewFrame = view3.bounds;
    labels = [_subLabels objectAtIndex:2];
    viewCount = labels.count;
    labelHeight = CGRectGetHeight(viewFrame);
    [self setupCapitalKey:labels.firstObject withHeight:labelHeight];
    [self setupDeleteKey:labels.lastObject withWidth:CGRectGetWidth(viewFrame) height:labelHeight];
    viewFrame = CGRectMake(kSpecialKeyWidth + kItemSpacing, 0, CGRectGetWidth(viewFrame) - (kSpecialKeyWidth + kItemSpacing) * 2, labelHeight);
    labelWidth = (CGRectGetWidth(viewFrame) - (viewCount - 3) * kItemSpacing) / (viewCount - 2);
    for (int i = 1; i < viewCount - 1; i++) {
        UILabel *label = [labels objectAtIndex:i];
        label.frame = CGRectMake((kSpecialKeyWidth + kItemSpacing) + (labelWidth + kItemSpacing) * (i - 1), 0, labelWidth, labelHeight);
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCharacter:)];
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:recognizer];
    }

    UIView *view4 = [_subViews objectAtIndex:3];
    view4.frame = CGRectMake(0, (viewHeight + kItemSpacing) * 3, viewWidth, viewHeight);
    viewFrame = view4.bounds;
    labels = [_subLabels objectAtIndex:3];
    viewCount = labels.count;
    labelWidth = (CGRectGetWidth(viewFrame) - (viewCount) * kItemSpacing) / viewCount;
    labelHeight = CGRectGetHeight(viewFrame);
    for (int i = 0; i < viewCount; i++) {
        UILabel *label = [labels objectAtIndex:i];
        label.frame = CGRectMake((labelWidth + kItemSpacing) * i, 0, labelWidth, labelHeight);
        [label setText:@"空格"];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSpace:)];
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:recognizer];
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

- (void)clickCapital:(UITapGestureRecognizer *)recognizer {
    _isCapital = !_isCapital;
    [self toggleCapitalCharacters];
    [self fillRandomCharacters];
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
    for (int i = 0; i < 9; i++) {
        UILabel *label = [self generateLabel];
        [line2 addObject:label];
        [view2 addSubview:label];
    }
    [_subViews addObject:view2];
    [_subLabels addObject:line2];

    UIView *view3 = [UIView new];
    [self addSubview:view3];
    NSMutableArray<UILabel *> *line3 = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UILabel *label = [self generateLabel];
        [line3 addObject:label];
        [view3 addSubview:label];
    }
    [_subViews addObject:view3];
    [_subLabels addObject:line3];

    UIView *view4 = [UIView new];
    [self addSubview:view4];
    NSMutableArray<UILabel *> *line4 = [NSMutableArray array];
    for (int i = 0; i < 1; i++) {
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

- (void)generateRandomCharacters {
    _randomCharacters = [NSMutableArray array];
    int start = 97;
    int end = 122;
    for (int i = 0; i < 26; i++) {
        NSString *randomString;
        do {
            int randomNumber = (int)(start + (arc4random() % (end - start + 1)));
            randomString = [NSString stringWithFormat:@"%c", randomNumber];
        } while ([_randomCharacters containsObject:randomString]);
        [_randomCharacters addObject:randomString];
    }
}

- (void) toggleCapitalCharacters {
    for (int i = 0; i < _subLabels.count; i++) {
        if (i == _subLabels.count - 1) {
            continue;
        }
        NSMutableArray<UILabel *> *labels = [_subLabels objectAtIndex:i];
        for (NSInteger j = 0; j < labels.count; j++) {
            if ((i == 2) && ((j == 0) || (j == labels.count - 1))) {
                continue;
            }
            UILabel *label = [labels objectAtIndex:j];
            int number = [label.text characterAtIndex:0];
            number = (_isCapital ? (number - 32) : (number + 32));
            [label setText:[NSString stringWithFormat:@"%c", number]];
        }
    }
}

- (void)fillRandomCharacters {
    for (int i = 0; i < _subLabels.count; i++) {
        NSMutableArray<UILabel *> *labels = [_subLabels objectAtIndex:i];
        for (NSInteger j = labels.count - 1; j >= 0; j--) {
            if (_randomCharacters.count == 0) {
                break;
            }
            if ((i == 2) && ((j == 0) || (j == labels.count - 1))) {
                continue;
            }
            NSString *character = _randomCharacters.lastObject;
            [_randomCharacters removeLastObject];
            [[labels objectAtIndex:j] setText:character];
        }
    }
}

- (void)setupCapitalKey:(UILabel *)label withHeight:(CGFloat)labelHeight {
    label.frame = CGRectMake(0, 0, kSpecialKeyWidth, labelHeight);
    [label setText:@"大写"];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCapital:)];
    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:recognizer];
}

- (void)setupDeleteKey:(UILabel *)label withWidth:(CGFloat)labelWidth height:(CGFloat)labelHeight {
    label.frame = CGRectMake(labelWidth - kSpecialKeyWidth, 0, kSpecialKeyWidth, labelHeight);
    [label setText:@"删除"];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDelete:)];
    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:recognizer];
}

@end
