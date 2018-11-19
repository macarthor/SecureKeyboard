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

// In this header, you should import all the public headers of your framework using statements like #import <NSKSecureKeyboard/PublicHeader.h>

typedef NS_ENUM(NSUInteger, NSKSecureKeyboardType) {
    NSKSecureKeyboardTypeSymbol,
    NSKSecureKeyboardTypeCharacter,
    NSKSecureKeyboardTypeNumber
};

@interface NSKSecureKeyboard : NSObject

+ (instancetype)initWithTextField:(UITextField *)textField keyboardType:(NSKSecureKeyboardType)keyboardType;

- (NSString *)getPassword;

@end

NS_ASSUME_NONNULL_END
