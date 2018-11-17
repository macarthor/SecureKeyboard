//
//  NSKKeyboardTypingDelegate.h
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSKKeyboardTypingDelegate <NSObject>

- (void)typeACharacter:(NSString *)character;

- (void)typeDelete;

@end

NS_ASSUME_NONNULL_END
