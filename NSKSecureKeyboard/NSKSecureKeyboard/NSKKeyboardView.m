//
//  NSKKeyboardView.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKKeyboardView.h"
#import "NSKKeyboardViewFactory.h"

@interface NSKKeyboardView ()

#define kSeparatorViewHeight 1
#define kTitleViewHeight 44
#define kKeyboardTypingViewHeight 200
#define kViewHeight (kSeparatorViewHeight + kTitleViewHeight + kKeyboardTypingViewHeight)

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic) NSKSecureKeyboardType keyboardType;

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *typingView;

@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation NSKKeyboardView

+ (instancetype)getViewWithTextField:(UITextField *)textField keyboardType:(NSKSecureKeyboardType)keyboardType {
    CGRect keyboardViewBounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kViewHeight);
    NSKKeyboardView *keyboardView = [[NSKKeyboardView alloc] initWithFrame:keyboardViewBounds];
    keyboardView.textField = textField;
    [keyboardView.textField setInputView:keyboardView];
    keyboardView.keyboardType = keyboardType;
    return keyboardView;
}

#pragma mark - override UIView methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _separatorView.frame = CGRectMake(0, 0, self.frame.size.width, kSeparatorViewHeight);
    _titleView.frame = CGRectMake(0, kSeparatorViewHeight, self.frame.size.width, kTitleViewHeight);
    _typingView.frame = CGRectMake(0, kSeparatorViewHeight + kTitleViewHeight, self.frame.size.width, kKeyboardTypingViewHeight);
}

#pragma mark - Private methods

- (void)setupSubViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.separatorView];
    [self addSubview:self.titleView];
    [self addSubview:self.keyboardView];
    [_typingView addSubview:[NSKKeyboardViewFactory getKeyboardView:self.keyboardType]];
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [UIView new];
        [_separatorView setBackgroundColor:[UIColor colorWithRed:170 green:170 blue:170 alpha:1]];
    }
    return _separatorView;
}

- (UIView *)titleView {
    if (!_titleView) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/NSKSecureKeyboard.framework/NSKSecureKeyboardBundle" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        _titleView = ((UIView *) [[bundle loadNibNamed:@"TitleView" owner:nil options:nil] firstObject]);//.subviews.firstObject;
        _finishButton = _titleView.subviews.firstObject.subviews.firstObject;
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    return _titleView;
}

- (UIView *)keyboardView {
    if (!_typingView) {
        _typingView = [UIView new];
        [_typingView setBackgroundColor:[UIColor greenColor]];
    }
    return _typingView;
}

@end
//
