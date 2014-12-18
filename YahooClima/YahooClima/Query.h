//
//  Query.h
//  YahooClima
//
//  Created by Apocalapsus on 12/17/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Query : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * woeid;

@end
