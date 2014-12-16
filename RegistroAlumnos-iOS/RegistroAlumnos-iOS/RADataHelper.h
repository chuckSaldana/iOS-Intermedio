//
//  RADataHelper.h
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RARegistro.h"

@interface RADataHelper : NSObject

@property (strong, nonatomic) RARegistro *registro;

+(RADataHelper *)sharedInstance;

@end
