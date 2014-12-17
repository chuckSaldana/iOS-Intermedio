//
//  YCQuery.h
//  YahooClima
//
//  Created by Apocalapsus on 12/17/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCQuery : NSObject

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *woeid;
@property (strong, nonatomic) NSString *text;

@end
