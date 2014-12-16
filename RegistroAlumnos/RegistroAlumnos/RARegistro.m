//
//  RARegistro.m
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RARegistro.h"

@implementation RARegistro {
    NSMutableArray *alumnos;
    NSMutableArray *aulas;
    NSMutableArray *instructores;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        alumnos = [[NSMutableArray alloc] init];
        aulas = [[NSMutableArray alloc] init];
        instructores = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addAlumno:(RAAlumno *)alumno {
    [alumnos addObject:alumno];
}

- (void)addAula:(RAAula *)aula {
    [aulas addObject:aula];
}

- (void)addInstructor:(RAInstructor *)instructor {
    [instructores addObject:instructor];
}

- (void)alumnos {
    for (RAAlumno *alumno in alumnos) {
        NSLog(@"Alumno: %@", alumno);
    }
}

- (void)aulas {
    for (RAAula *aula in aulas) {
        NSLog(@"Aula: %@", aula);
    }
}

- (void)instructores {
    for (int index = 0; index < [instructores count]; index ++) {
        NSLog(@"Instructor: %@", instructores[index]);
    }
}

@end
