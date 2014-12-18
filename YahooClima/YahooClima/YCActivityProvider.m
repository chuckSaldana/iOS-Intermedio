//
//  YCActivityProvider.m
//  YahooClima
//
//  Created by Apocalapsus on 12/18/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "YCActivityProvider.h"

@implementation YCActivityProvider 

- (id) activityViewController:(UIActivityViewController *)activityViewController
          itemForActivityType:(NSString *)activityType {
    
    if ([activityType isEqualToString:UIActivityTypePostToTwitter])
        return @"Hola Twitter baja la app de Yahooo Clima!";
    if ([activityType isEqualToString:UIActivityTypePostToFacebook])
        return [NSString stringWithFormat:@"Mi hubicacion es: %f %f", self.latitud, self.longitud];
    
    return @"Baja la nueva app de Yahooo Clima";

}

- (id) activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return @"";
}

@end
