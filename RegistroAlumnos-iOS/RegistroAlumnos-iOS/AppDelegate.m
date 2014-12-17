//
//  AppDelegate.m
//  RegistroAlumnos-iOS
//
//  Created by Apocalapsus on 12/15/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "AppDelegate.h"
// Importacion de View controllers que se van a usar
#import "RALoginVC.h"
#import "RARegistroVC.h"
#import "RAListasVC.h"
#import "RAConfigVC.h"
#import "RAAboutVC.h"
#import "RADataHelper.h"

@interface AppDelegate () <RALoginVCDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Inicializacion del window de la aplicacion.
    self.window = [[UIWindow alloc] initWithFrame:
                   [[UIScreen mainScreen] applicationFrame]];
    self.window.backgroundColor = [UIColor greenColor];
    // Ajuste de la posicion del window.
    self.window.center = CGPointMake(self.window.center.x, self.window.center.y - 20);
    
    [self llenarDatosIniciales];
    
    // Creamos el tab bar controller que contendra a todas las pantallas
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    RARegistroVC *registroVC = [[RARegistroVC alloc] init];
    registroVC.tabBarItem.title = @"Registro";
    
    // Creamos el Navigation controller que va a contener al viewcontroller de listas
    UINavigationController *listasNVC = [[UINavigationController alloc] init];
    RAListasVC *listasVC = [[RAListasVC alloc] init];
    [listasNVC pushViewController:listasVC animated:NO];
    listasNVC.tabBarItem.title = @"Listas";
    
    RAConfigVC *configVC = [[RAConfigVC alloc] init];
    configVC.tabBarItem.title = @"Configuración";
    
    RAAboutVC *aboutVC = [[RAAboutVC alloc] init];
    aboutVC.tabBarItem.title = @"About";
    
    // Los view controllers del tabBarController se especifican por medio de un arreglo.
    NSArray *controllers = @[registroVC, listasNVC, configVC, aboutVC];
    tabBarController.viewControllers = controllers;
    
    // El tabBarController se convierte en el viewController raiz de la aplicación.
    self.window.rootViewController = tabBarController;
    // Haz visible el window y la gerarquia de vistas.
    [self.window makeKeyAndVisible];
    [self showNotification];
    
    return YES;
}

- (void)showNotification {
    
//    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        //  Notify user of zone entry.  This event fires even if app is inactive
        UIApplication* app = [UIApplication sharedApplication];
        UILocalNotification* notifyAlarm = [[UILocalNotification alloc] init];
        if (notifyAlarm) {
            notifyAlarm.repeatInterval = 0;
            notifyAlarm.soundName = UILocalNotificationDefaultSoundName;
            NSString *alertText = @"Do you want to see more?";
            notifyAlarm.alertBody = alertText;
            notifyAlarm.userInfo = @{@"location":@""};
            //[app presentLocalNotificationNow:notifyAlarm];
            notifyAlarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
            [app scheduleLocalNotification:notifyAlarm];
        }
    //}
}

- (void)presentLogin {
    
    if (self.window.rootViewController.presentedViewController == nil) {
        RALoginVC *loginVC = [[RALoginVC alloc] init];
        loginVC.delegate = self;
        
        [self.window.rootViewController presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)loginVCdidLogin:(RALoginVC *)loginVC {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)llenarDatosIniciales {
    RARegistro *registro = [[RADataHelper sharedInstance] registro];
    
    // Creamos 10 instructores con numeros al final del nombre
    for (int index = 0; index < 10; index ++) {
        NSString *nombre = [NSString stringWithFormat:@"Carlos %i", index];
        NSNumber *matricula = [NSNumber numberWithInt:index];
        RAInstructor *instructor = [[RAInstructor alloc] init];
        instructor.nombre = nombre;
        instructor.matricula = matricula;
        
        [registro addInstructor:instructor];
    }
    
    // Asignamos un instructor random a las aulas
    NSArray *instructores = [registro instructores];
    unsigned long limit = ([instructores count] - 1);
    int instructorIndex = arc4random_uniform((unsigned int)limit);
    
    RAAula *aula1 = [[RAAula alloc] init];
    aula1.identifier = @1;
    aula1.capacidad = @40;
    aula1.instructor = instructores[instructorIndex];
    RAAula *aula2 = [[RAAula alloc] init];
    aula2.identifier = @2;
    aula2.capacidad = @40;
    aula1.instructor = instructores[instructorIndex];
    
    [registro addAula:aula1];
    [registro addAula:aula2];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // Recuperar user info
    
    // Presentar contenido relacionado
//    [self.window.rootViewController presentViewController:<#(UIViewController *)#>
//                                                 animated:<#(BOOL)#>
//                                               completion:<#^(void)completion#>]
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Por medio de los userDefaults revisamos si autologin esta habilitado.
    BOOL isAutoLoginEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"auto-login-enabled"];
    if (isAutoLoginEnabled == NO) {
        // Si esta deshabilitado, manda presentar el ViewController de Login depues de un segundo
        // para dejar que las animaciones iniciales se realicen eficientemente.
        [self presentLogin];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
