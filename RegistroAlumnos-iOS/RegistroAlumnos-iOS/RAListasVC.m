//
//  RAListasVC.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RAListasVC.h"
#import "RADataHelper.h"
#import "RADetailleAlumno.h"

@interface RAListasVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RAListasVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *items = @[@"Alumnos", @"Aulas", @"Instructores"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    self.segmentedControl.momentary = NO;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newUserAdded:)
                                                 name:@"UserAdded"
                                               object:nil];
}

- (void)newUserAdded:(NSNotification *)notification {
    NSLog(@"User Info %@", notification.userInfo);
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.tableView reloadData];
}

- (void)segmentedControlTapped:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return [[[[RADataHelper sharedInstance] registro] alumnos] count];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        return [[[[RADataHelper sharedInstance] registro] aulas] count];
    }
    else {
        return [[[[RADataHelper sharedInstance] registro] instructores] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        RAAlumno *alumno = [[[RADataHelper sharedInstance] registro] alumnos][indexPath.row];
        cell.textLabel.text = alumno.nombre;
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        RAAula *aula = [[[RADataHelper sharedInstance] registro] aulas][indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"Aula %@", aula.identifier];
    }
    if (self.segmentedControl.selectedSegmentIndex == 2) {
        RAInstructor *instructor = [[[RADataHelper sharedInstance] registro] instructores][indexPath.row];
        cell.textLabel.text = instructor.nombre;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        RAAlumno *alumno = [[[RADataHelper sharedInstance] registro] alumnos][indexPath.row];
        RADetailleAlumno *detalleAlumno = [[RADetailleAlumno alloc] initWithAlumno:alumno];
        [self.navigationController pushViewController:detalleAlumno animated:YES];
    } 
}

@end






