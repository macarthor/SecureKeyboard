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

// subviews of self.titleView
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, strong) UILabel  *titleLabel;

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

#pragma mark - click actions

-(void)clickFinishButton:(id)sender {
    [self.textField endEditing:YES];
}

-(void)switchToSym:(UITapGestureRecognizer *)gesture {
    self.keyboardType = NSKSecureKeyboardTypeSymbol;
    [[_typingView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_typingView addSubview:[NSKKeyboardViewFactory getKeyboardView:self.keyboardType]];
    [self highlightLabel:self.keyboardType];
}

-(void)switchToChar:(UITapGestureRecognizer *)gesture {
    self.keyboardType = NSKSecureKeyboardTypeCharacter;
    [[_typingView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_typingView addSubview:[NSKKeyboardViewFactory getKeyboardView:self.keyboardType]];
    [self highlightLabel:self.keyboardType];
}

-(void)switchToNum:(UITapGestureRecognizer *)gesture {
    self.keyboardType = NSKSecureKeyboardTypeNumber;
    [[_typingView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_typingView addSubview:[NSKKeyboardViewFactory getKeyboardView:self.keyboardType]];
    [self highlightLabel:self.keyboardType];
}

#pragma mark - Private methods

- (void)setupSubViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.separatorView];
    [self addSubview:self.titleView];
    [self addSubview:self.typingView];
    [_typingView addSubview:[NSKKeyboardViewFactory getKeyboardView:self.keyboardType]];
    [self highlightLabel:self.keyboardType];
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [UIView new];
        [_separatorView setBackgroundColor:[UIColor colorWithRed:(170/255.0f) green:(170/255.0f) blue:(170/255.0f) alpha:1]];
    }
    return _separatorView;
}

- (UIView *)titleView {
    if (!_titleView) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/NSKSecureKeyboard.framework/NSKSecureKeyboardBundle" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        _titleView = ((UIView *) [[bundle loadNibNamed:@"TitleView" owner:nil options:nil] firstObject]);

        _finishButton = [_titleView.subviews.firstObject.subviews objectAtIndex:0];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(clickFinishButton:) forControlEvents:UIControlEventTouchUpInside];

        _labels = [NSMutableArray arrayWithCapacity:3];

        [_labels setObject:[_titleView.subviews.firstObject.subviews objectAtIndex:1] atIndexedSubscript:0];
        UILabel *symLabel = [_labels objectAtIndex:0];
        [symLabel setText:@"符号"];
        UITapGestureRecognizer *recognizerSym = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToSym:)];
        symLabel.userInteractionEnabled = YES;
        [symLabel addGestureRecognizer:recognizerSym];

        [_labels setObject:[_titleView.subviews.firstObject.subviews objectAtIndex:2] atIndexedSubscript:1];
        UILabel *charLabel = [_labels objectAtIndex:1];
        [charLabel setText:@"字母"];
        UITapGestureRecognizer *recognizerChar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToChar:)];
        charLabel.userInteractionEnabled = YES;
        [charLabel addGestureRecognizer:recognizerChar];

        [_labels setObject:[_titleView.subviews.firstObject.subviews objectAtIndex:3] atIndexedSubscript:2];
        UILabel *numLabel = [_labels objectAtIndex:2];
        [numLabel setText:@"数字"];
        UITapGestureRecognizer *recognizerNum = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToNum:)];
        numLabel.userInteractionEnabled = YES;
        [numLabel addGestureRecognizer:recognizerNum];

        _titleLabel = [_titleView.subviews.firstObject.subviews objectAtIndex:4];
        [_titleLabel setText:@"安全键盘"];
    }
    return _titleView;
}

- (UIView *)typingView {
    if (!_typingView) {
        _typingView = [UIView new];
        [_typingView setBackgroundColor:[UIColor greenColor]];
    }
    return _typingView;
}

- (void)highlightLabel:(NSKSecureKeyboardType)keyboardType {
    UIColor *color;
    for (int i = 0; i < _labels.count; i++) {
        if (i == keyboardType) {
            color = [UIColor colorWithRed:(17/255.0f) green:(111/255.0f) blue:(181/255.0f) alpha:1];
        } else {
            color = [UIColor lightGrayColor];
        }
        [[_labels objectAtIndex:i] setTextColor:color];
    }
}

@end
