//
//  RAAlumno.h
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAAula.h"

@interface RAAlumno : NSObject

- (instancetype)initWithNombre:(NSString *)nombre matricula:(NSNumber *)matricula;

@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) NSNumber *matricula;
@property (strong, nonatomic) RAAula *aula;

@end
