//
//  RADataHelper.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RADataHelper.h"

@implementation RADataHelper

+(RADataHelper *)sharedInstance {
    // pred se asegura que la ejecucion del bloque sea solo una vez
    // durante la vida de la aplicacion.
    static dispatch_once_t pred;
    // shared es una variable estatica que contiene la referencia al objeto unico
    static RADataHelper *shared = nil;
    dispatch_once(&pred, ^{
        // Inicialización básica de la instancia
        shared = [[RADataHelper alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.registro = [[RARegistro alloc] init];
    }
    return self;
}

@end
