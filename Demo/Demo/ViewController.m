//
//  ViewController.m
//  Demo
//
//  Created by McArthor Lee on 2018/11/13.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "ViewController.h"
#import <NSKSecureKeyboard/NSKSecureKeyboard.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.layer.borderColor = [[UIColor redColor] CGColor];
    self.textField.layer.borderWidth = 5.0f;
    self.textField.layer.cornerRadius = 20.0f;
    [NSKSecureKeyboard initWithTextField:self.textField keyboardType:NSKSecureKeyboardTypeSymbol];
}


@end
