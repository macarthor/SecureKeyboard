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

@end

@implementation NSKSecureKeyboard

+ (instancetype)initWithTextField:(UITextField *)textField
                     keyboardType:(NSKSecureKeyboardType)keyboardType {
    NSKSecureKeyboard *secureKeyboard = [NSKSecureKeyboard new];
    secureKeyboard.keyboardView = [NSKKeyboardView getViewWithTextField:textField keyboardType:keyboardType];
    return secureKeyboard;
}

- (NSString *)getPassword {
    return [_keyboardView getPassword];
}

@end
