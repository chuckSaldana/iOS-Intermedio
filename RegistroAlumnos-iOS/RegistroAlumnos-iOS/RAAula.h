//
//  RAAula.h
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAInstructor.h"

@interface RAAula : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSNumber *capacidad;
@property (strong, nonatomic) RAInstructor *instructor;

@end
