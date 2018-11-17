//
//  NSKKeyboardTypingView.h
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//
//  A view that can type characters.
//

#import <UIKit/UIKit.h>
#import "NSKKeyboardTypingDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#define FRAMEWORK_BUNDLE ([NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Frameworks/NSKSecureKeyboard.framework/NSKSecureKeyboardBundle" ofType:@"bundle"]])

@interface NSKKeyboardTypingView : UIView

@property (nonatomic, strong) id<NSKKeyboardTypingDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
