//
//  NSKSecureKeyboard.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKSecureKeyboard.h"
#import "NSKKeyboardView.h"

@interface NSKSecureKeyboard ()

@property (nonatomic, strong) NSKKeyboardView *keyboardView;

@property (nonatomic, strong) NSMutableString *blankPassword;

@end

@implementation NSKSecureKeyboard

+ (instancetype)initWithTextField:(UITextField *)textField
                     keyboardType:(NSKSecureKeyboardType)keyboardType {
    NSKSecureKeyboard *secureKeyboard = [NSKSecureKeyboard new];
    secureKeyboard.keyboardView = [NSKKeyboardView getViewWithTextField:textField keyboardType:keyboardType typingDelegate:secureKeyboard];
    return secureKeyboard;
}

- (NSString *)getPassword {
    return _blankPassword;
}

#pragma mark - NSKKeyboardTypingDelegate methods

- (void)typeACharacter:(NSString *)character {
    NSUInteger position = [_keyboardView getTextFieldCursorPosition];
    if (position > _blankPassword.length) {
        return;
    }
    if (!_blankPassword) {
        _blankPassword = [NSMutableString string];
    }
    [_blankPassword insertString:character atIndex:position];

    [_keyboardView setTextFieldWithText:_blankPassword cursorPosition:position + 1];
}

- (void)typeDelete {
    if (!_blankPassword || _blankPassword.length == 0) {
        return;
    }
    NSUInteger position = [_keyboardView getTextFieldCursorPosition];
    if (position == 0) {
        return;
    }
    [_blankPassword deleteCharactersInRange:NSMakeRange(position - 1, 1)];

    [_keyboardView setTextFieldWithText:_blankPassword cursorPosition:position - 1];
}

@end
