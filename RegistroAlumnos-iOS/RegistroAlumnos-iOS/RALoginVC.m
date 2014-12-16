//
//  RALoginVC.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "RALoginVC.h"

@interface RALoginVC ()

@end

@implementation RALoginVC

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

- (IBAction)tapLoginButton:(id)sender {
    
    if ([self validCredentials]) {
        [self.delegate loginVCdidLogin:self];
    }
    else {
        [self presentErrorAlert];
    }
}

- (BOOL)validCredentials {
    if ([self.userNameTxt.text isEqualToString:@"admin"] &&
        [self.passwordTxt.text isEqualToString:@"123"]) {
        return YES;
    }
    return NO;
}

- (void)presentErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Credenciales inválidas"
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles: nil];
    [alert show];
}


@end










