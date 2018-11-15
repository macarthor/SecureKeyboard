//
//  NSKKeyboardViewFactory.h
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//
//  Generate a NSKKeyboardTypingView based on keyboard type.
//

#import <Foundation/Foundation.h>
#import "NSKSecureKeyboard.h"
#import "NSKKeyboardTypingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSKKeyboardViewFactory : NSObject

+ (NSKKeyboardTypingView *)getKeyboardView:(NSKSecureKeyboardType)keyboardType;

@end

NS_ASSUME_NONNULL_END
