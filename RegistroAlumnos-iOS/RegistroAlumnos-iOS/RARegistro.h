//
//  RARegistro.h
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RAAlumno.h"
#import "RAAula.h"
#import "RAInstructor.h"

@interface RARegistro : NSObject

- (void)addAlumno:(RAAlumno *)alumno;
- (void)addAula:(RAAula *)aula;
- (void)addInstructor:(RAInstructor *)instructor;

- (NSArray *)alumnos;
- (NSArray *)aulas;
- (NSArray *)instructores;

@end
