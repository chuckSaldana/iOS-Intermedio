//
//  main.m
//  RegistroAlumnos
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RARegistro.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        RARegistro *registro = [[RARegistro alloc] init];
        RAAlumno *alumno = [[RAAlumno alloc] initWithNombre:@"Carlos" matricula:nil];
        [registro addAlumno:alumno];
//        RAAula *aula = [[RAAula alloc] init];
//        [registro addAula:aula];
//        RAInstructor *instructor = [[RAInstructor alloc] init];
//        [registro addInstructor:instructor];
        
        [registro alumnos];
        
    }
    return 0;
}
