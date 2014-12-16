//
//  RADetailleAlumno.h
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/16/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAAlumno.h"

@interface RADetailleAlumno : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nombreLbl;
@property (weak, nonatomic) IBOutlet UILabel *matriculaLbl;

- (id)initWithAlumno:(RAAlumno *)alumno;

@end
