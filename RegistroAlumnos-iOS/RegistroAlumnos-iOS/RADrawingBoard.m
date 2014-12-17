//
//  RADrawingBoard.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/17/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RADrawingBoard.h"

@implementation RADrawingBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self addRectangleAtPoint:point];
    NSLog(@"began touches %@", touches);
//    for (UITouch *touch in [touches allObjects]) {
//        CGPoint point = [touch locationInView:self];
//        [self addRectangleAtPoint:point];
//    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self addRectangleAtPoint:point];
    NSLog(@"began touches %@", touches);
//    for (UITouch *touch in [touches allObjects]) {
//        CGPoint point = [touch locationInView:self];
//        [self addRectangleAtPoint:point];
//    }
}

- (void)addRectangleAtPoint:(CGPoint)point {
    CGRect colorFr = CGRectMake(point.x - 2,
                                point.y - 2,
                                4, 4);
    UIView *colorView = [[UIView alloc] initWithFrame:colorFr];
    colorView.backgroundColor = [UIColor redColor];
    
    [self addSubview:colorView];
    [self setNeedsDisplay];
}

@end














