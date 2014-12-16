//
//  RADetailleAlumno.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/16/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RADetailleAlumno.h"

@interface RADetailleAlumno ()

@property (strong, nonatomic) RAAlumno *alumno;

@end

@implementation RADetailleAlumno

- (id)initWithAlumno:(RAAlumno *)alumno {
    self = [super initWithNibName:@"RADetailleAlumno" bundle:[NSBundle mainBundle]];
    if (self) {
        self.alumno = alumno;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nombreLbl.text = self.alumno.nombre;
    self.matriculaLbl.text = [NSString stringWithFormat:@"Matricula: %@", self.alumno.matricula];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
