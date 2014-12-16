//
//  RASwitch.h
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/16/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RASwitch : UIView

- (id)initWithColor:(UIColor *)color state:(BOOL)state;
- (void)addTarget:(id)target action:(SEL)action;

@property (strong, nonatomic) UIColor *currentColor;
@property BOOL currentState;
@property (weak, nonatomic) id target;
@property SEL action;

@end
