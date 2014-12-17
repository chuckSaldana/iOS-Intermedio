//
//  RAConfigVC.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RAConfigVC.h"
#import "RASwitch.h"
#import "RADrawingBoard.h"

@interface RAConfigVC ()

@property (weak, nonatomic) IBOutlet UILabel *autoLbl;

@end

@implementation RAConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"auto-login-enabled"];
    RASwitch *raSwitch = [[RASwitch alloc] initWithColor:[UIColor redColor]
                                                   state:state];
    raSwitch.frame = CGRectMake(CGRectGetMaxX(self.autoLbl.frame) + 10,
                                    CGRectGetMinY(self.autoLbl.frame), 100, 50);
    [raSwitch addTarget:self action:@selector(switchTapped:)];
    [self.view addSubview:raSwitch];
    
    CGRect boardFrame = CGRectMake(CGRectGetMinX(self.autoLbl.frame),
                                   CGRectGetMaxY(self.autoLbl.frame),
                                   CGRectGetWidth(self.view.frame) - 20,
                                   400);
    RADrawingBoard *board = [[RADrawingBoard alloc] initWithFrame:boardFrame];
    [self.view addSubview:board];
}

- (void)switchTapped:(RASwitch *)raSwitch {
    [[NSUserDefaults standardUserDefaults] setBool:raSwitch.currentState
                                            forKey:@"auto-login-enabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
