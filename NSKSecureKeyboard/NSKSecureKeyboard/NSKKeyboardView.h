//
//  NSKKeyboardView.h
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//
//  The whole UIView of the keyboard, including a NSKKeyboardTypingView instance and a title UIView.
//

#import <UIKit/UIKit.h>
#import "NSKSecureKeyboard.h"
#import "NSKKeyboardTypingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSKKeyboardView : UIView <NSKKeyboardTypingDelegate>

+ (instancetype)getViewWithTextField:(UITextField *)textField keyboardType:(NSKSecureKeyboardType)keyboardType;

- (instancetype)initWithFrame:(CGRect)frame keyboardType:(NSKSecureKeyboardType)keyboardType;

- (NSUInteger)getTextFieldCursorPosition;
- (void)setTextFieldWithText:(NSString *)text cursorPosition:(NSUInteger)position;
- (NSString *)getPassword;

@end

NS_ASSUME_NONNULL_END
