//
//  RASwitch.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/16/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RASwitch.h"

@interface RASwitch ()

@property (strong, nonatomic) UIView *vistaIzquierda;
@property (strong, nonatomic) UIView *vistaDerecha;
@property (strong, nonatomic) UIColor *shadowColor;

@end

@implementation RASwitch

- (id)initWithColor:(UIColor *)color state:(BOOL)state {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.currentColor = color;
        self.currentState = state;
        self.shadowColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGRect izqFrame = CGRectMake(2, 2, (self.frame.size.width / 2) - 3, self.frame.size.height - 4);
    self.vistaIzquierda = [[UIView alloc] initWithFrame:izqFrame];
    self.vistaIzquierda.backgroundColor = self.currentColor;
    UILabel *offLbl = [[UILabel alloc] initWithFrame:self.vistaIzquierda.bounds];
    offLbl.textColor = [UIColor whiteColor];
    offLbl.text = @"OFF";
    offLbl.font = [UIFont systemFontOfSize:12];
    offLbl.textAlignment = NSTextAlignmentCenter;
    [self.vistaIzquierda addSubview:offLbl];
    
    CGRect derFrame = CGRectMake((self.frame.size.width / 2) + 1, 2,
                                 (self.frame.size.width / 2) - 3, self.frame.size.height - 4);
    self.vistaDerecha = [[UIView alloc] initWithFrame:derFrame];
    self.vistaDerecha.backgroundColor = self.shadowColor;
    UILabel *onLbl = [[UILabel alloc] initWithFrame:self.vistaDerecha.bounds];
    onLbl.textColor = [UIColor whiteColor];
    onLbl.text = @"ON";
    onLbl.textAlignment = NSTextAlignmentCenter;
    [self.vistaDerecha addSubview:onLbl];
    
    self.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.vistaIzquierda];
    [self addSubview:self.vistaDerecha];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] > 0) {
        UITouch *touch = [touches anyObject];
        if ([touch.view isEqual:self.vistaDerecha]) {
            
            [UIView animateWithDuration:.5 animations:^{
                self.vistaDerecha.backgroundColor = self.currentColor;
                self.vistaIzquierda.backgroundColor = self.shadowColor;
            }];
            self.currentState = YES;
        }
        else if ([touch.view isEqual:self.vistaIzquierda]) {
            [UIView animateWithDuration:.5 animations:^{
                self.vistaIzquierda.backgroundColor = self.currentColor;
                self.vistaDerecha.backgroundColor = self.shadowColor;
            }];
            self.currentState = NO;
        }
        
        if (self.target != nil) {
            [self.target performSelector:self.action withObject:self];
        }
    }
}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}

@end
