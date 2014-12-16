//
//  RARegistroVC.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RARegistroVC.h"
#import "RADataHelper.h"

@interface RARegistroVC () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nombreTxt;
@property (weak, nonatomic) IBOutlet UITextField *matriculaTxt;
@property (weak, nonatomic) IBOutlet UIPickerView *aulaPicker;
- (IBAction)saveButtonTapped:(id)sender;

@end

@implementation RARegistroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)saveButtonTapped:(id)sender {
    
    NSNumber *matricula = [NSNumber numberWithInt:[self.matriculaTxt.text intValue]];
    RAAlumno *nuevoAlumno = [[RAAlumno alloc] initWithNombre:self.nombreTxt.text
                                                   matricula:matricula];
    [[[RADataHelper sharedInstance] registro] addAlumno:nuevoAlumno];
    
    [self.nombreTxt resignFirstResponder];
    [self.matriculaTxt resignFirstResponder];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:nuevoAlumno
                                                         forKey:@"alumno"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAdded"
                                                        object:self
                                                      userInfo:userInfo];
}

#pragma mark - UIPickerViewDelegate conformance

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *aulas = [[[RADataHelper sharedInstance] registro] aulas];
    return [aulas count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSArray *aulas = [[[RADataHelper sharedInstance] registro] aulas];
    RAAula *aula = [aulas objectAtIndex:row];
    return [NSString stringWithFormat:@"Aula %@", aula.identifier];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    aulaSeleccionada = (int)row;
}

@end
