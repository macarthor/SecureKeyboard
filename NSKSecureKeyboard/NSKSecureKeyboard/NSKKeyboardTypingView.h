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

NS_ASSUME_NONNULL_BEGIN

@interface NSKKeyboardTypingView : UIView

- (void)typeACharacter:(NSString *)character;

- (void)typeDelete;

@end

NS_ASSUME_NONNULL_END
