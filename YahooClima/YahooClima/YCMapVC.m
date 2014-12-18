//
//  YCMapVC.m
//  YahooClima
//
//  Created by Apocalapsus on 12/18/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "YCMapVC.h"
#import "YCActivityProvider.h"
#import <MapKit/MapKit.h>

@interface YCMapVC ()
- (IBAction)volver:(UIBarButtonItem *)sender;
- (IBAction)share:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@end

@implementation YCMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.showsUserLocation = YES;
    self.shareButton.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetLocationNotification:)
                                                 name:@"didGetLocation"
                                               object:nil];
}

- (void)didGetLocationNotification:(NSNotification *)notification {
    
    //self.location = notification.object;
    self.shareButton.enabled = YES;
    self.location = notification.userInfo[@"location"];
    [self.mapView setCenterCoordinate:self.location.coordinate animated:YES];
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

- (IBAction)volver:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)share:(UIBarButtonItem *)sender {
    
    YCActivityProvider *activityP = [[YCActivityProvider alloc] init];
    if (self.location) {
        activityP.latitud = self.location.coordinate.latitude;
        activityP.longitud = self.location.coordinate.longitude;
    }
    else {
        activityP.latitud = 23.897698;
        activityP.longitud = -103.372409;
    }
    
    NSArray *items = @[activityP];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                    initWithActivityItems:items
                                                    applicationActivities:nil];
    [activityController setExcludedActivityTypes:
     @[UIActivityTypePrint,
       UIActivityTypeCopyToPasteboard,
       UIActivityTypeAssignToContact,
       UIActivityTypeSaveToCameraRoll,
       UIActivityTypePostToWeibo,
       UIActivityTypePostToFlickr,
       UIActivityTypePostToVimeo,
       UIActivityTypePostToTencentWeibo]];
    
    [self presentViewController:activityController
                       animated:YES
                     completion:nil];
}


@end
















