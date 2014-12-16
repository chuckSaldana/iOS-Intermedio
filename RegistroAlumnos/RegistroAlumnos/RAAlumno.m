//
//  RAAlumno.m
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RAAlumno.h"

@implementation RAAlumno {
    NSNumber *_matricula;
}

@dynamic matricula;

- (void)setMatricula:(NSNumber *)matricula {
    if (!matricula || [matricula intValue] == 0) {
        _matricula = @99999;
    }
    else {
        _matricula = matricula;
    }
}

- (NSNumber *)matricula {
    return _matricula;
}

- (instancetype)initWithNombre:(NSString *)nombre matricula:(NSNumber *)matricula
{
    self = [super init];
    if (self) {
        self.nombre = nombre ? nombre : @"No especificado";
        self.matricula = matricula;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Nombre: %@, Matricula: %@",
            self.nombre,
            self.matricula];
}

@end
