//
//  RALoginVC.h
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RALoginVCDelegate;

@interface RALoginVC : UIViewController

@property (weak, nonatomic) id <RALoginVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
- (IBAction)tapLoginButton:(id)sender;

@end

@protocol RALoginVCDelegate <NSObject>

- (void)loginVCdidLogin:(RALoginVC *)loginVC;

@end
