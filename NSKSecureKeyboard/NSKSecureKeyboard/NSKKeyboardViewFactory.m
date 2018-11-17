//
//  NSKKeyboardViewFactory.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKKeyboardViewFactory.h"
#import "NSKKeyboardTypingNumView.h"

@implementation NSKKeyboardViewFactory

+ (NSKKeyboardTypingView *)getKeyboardView:(NSKSecureKeyboardType)keyboardType withFrame:(CGRect)frame {
    if (keyboardType == NSKSecureKeyboardTypeNumber) {
        return [[NSKKeyboardTypingNumView new] initWithFrame:frame];
    }
    return nil;
}

@end
