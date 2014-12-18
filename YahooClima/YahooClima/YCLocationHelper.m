//
//  YCLocationHelper.m
//  YahooClima
//
//  Created by Apocalapsus on 12/18/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "YCLocationHelper.h"
#import <CoreLocation/CoreLocation.h>

//https://developer.apple.com/ios/
//https://developer.apple.com/library/ios/navigation/

@interface YCLocationHelper () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation YCLocationHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self pedirPermiso];
    }
    return self;
}

- (void)pedirPermiso {
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)startGettingLocation {

    self.locationManager.distanceFilter = 100;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetLocation" object:location];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetLocation" object:self userInfo:@{@"location":location}];
    
    
    [self getWoeidWithLocation:location];
}

- (void)getWoeidWithLocation:(CLLocation *)location {

    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20geo.placefinder%%20where%%20text%%3D%%22%f%%2C%f%%22%%20and%%20gflags%%3D%%22R%%22&format=json", coordinate.latitude, coordinate.longitude];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                              
                               NSLog(@"Response %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                               
                               // Extraer WOEID
                               NSError *jsonError;
                               NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:NSJSONReadingAllowFragments
                                                                                       error:&jsonError];
                               if (!jsonError) {
                                   NSDictionary *query = responseDict[@"query"];
                                   NSDictionary *results = query[@"results"];
                                   NSDictionary *Result = results[@"Result"];
                                   NSString *woeid = Result[@"woeid"];
                                   NSString *city = Result[@"city"];
                                   
                                   // Avisar con NSNotificationCenter
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"didGetWoeid" object:woeid userInfo:@{@"city":city}];
                               }
                           }];
}

@end




/*
{
    "query": {
        "count": 1,
        "created": "2014-12-18T16:34:05Z",
        "lang": "en-us",
        "results": {
            "Result": {
                "quality": "87",
                "addressMatchType": "INTERPOLATED",
                "latitude": "37.332331",
                "longitude": "-122.031219",
                "offsetlat": "37.332331",
                "offsetlon": "-122.031219",
                "radius": "400",
                "name": "37.332331,-122.031219",
                "line1": "1 Infinite Loop",
                "line2": "Cupertino, CA 95014-2083",
                "line3": null,
                "line4": "United States",
                "house": "1",
                "street": "Infinite Loop",
                "xstreet": null,
                "unittype": null,
                "unit": null,
                "postal": "95014-2083",
                "neighborhood": null,
                "city": "Cupertino",
                "county": "Santa Clara County",
                "state": "California",
                "country": "United States",
                "countrycode": "US",
                "statecode": "CA",
                "countycode": null,
                "uzip": "95014",
                "hash": "0B730171A22CFC09",
                "woeid": "12797509",
                "woetype": "11"
            }
        }
    }
}
 */









