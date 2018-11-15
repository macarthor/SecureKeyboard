//
//  NSKSecureKeyboard.h
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//
//  Manager class to manage views.
//  This is the entrance class of the framework library.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//! Project version number for NSKSecureKeyboard.
FOUNDATION_EXPORT double NSKSecureKeyboardVersionNumber;

//! Project version string for NSKSecureKeyboard.
FOUNDATION_EXPORT const unsigned char NSKSecureKeyboardVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <NSKSecureKeyboard/PublicHeader.h>

typedef NS_ENUM(NSUInteger, NSKSecureKeyboardType) {
    NSKSecureKeyboardTypeNumber,
    NSKSecureKeyboardTypeSymbol,
    NSKSecureKeyboardTypeCharacter
};

@interface NSKSecureKeyboard : NSObject

+ (instancetype)initWithTextField:(UITextField *)textField keyboardType:(NSKSecureKeyboardType)keyboardType;

@end

NS_ASSUME_NONNULL_END
