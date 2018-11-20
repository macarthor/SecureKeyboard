//
//  NSKKeyboardViewFactory.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKKeyboardViewFactory.h"
#import "NSKKeyboardTypingNumView.h"
#import "NSKKeyboardTypingCharacterView.h"

@implementation NSKKeyboardViewFactory

+ (NSKKeyboardTypingView *)getKeyboardView:(NSKSecureKeyboardType)keyboardType withFrame:(CGRect)frame {
    NSKKeyboardTypingView *view = nil;
    switch (keyboardType) {
        case NSKSecureKeyboardTypeNumber:
            view = [[NSKKeyboardTypingNumView new] initWithFrame:frame];
            break;

        case NSKSecureKeyboardTypeCharacter:
            view = [[NSKKeyboardTypingCharacterView new] initWithFrame:frame];
            break;

        case NSKSecureKeyboardTypeSymbol:
            break;

        default:
            break;
    }
    return view;
}

@end
