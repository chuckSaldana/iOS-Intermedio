//
//  ViewController.m
//  YahooClima
//
//  Created by Apocalapsus on 12/17/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "ViewController.h"
#import "YCQuery.h"
#import "Query.h"
#import "AppDelegate.h"
#import "YCLocationHelper.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *queries;
@property (weak, nonatomic) IBOutlet  UITextField *queryTxt;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) YCLocationHelper *locationHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.queries = [NSMutableArray array];
    self.context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Query"];
    NSError *error;
    self.queries = [[self.context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    [self.tableView reloadData];
    
    self.locationHelper = [[YCLocationHelper alloc] init];
    [self.locationHelper startGettingLocation];
}

- (IBAction)queryButtonTapped:(id)sender {
    [self.queryTxt resignFirstResponder];
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadData {
    @autoreleasepool {
      //======================================================================
        NSEntityDescription *description = [NSEntityDescription entityForName:@"Query"
                                                       inManagedObjectContext:self.context];
        Query *cdQuery = [[Query alloc] initWithEntity:description
                        insertIntoManagedObjectContext:self.context];
        cdQuery.woeid = self.queryTxt.text;
      //======================================================================
        
        
        __block YCQuery *query = [[YCQuery alloc] init];
        query.woeid = self.queryTxt.text;
        
        NSString *urlStr = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select+item.condition+from+weather.forecast+where+woeid+%%3D%@&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys", query.woeid];
        //https://query.yahooapis.com/v1/public/yql?q=select+item.condition+from+weather.forecast+where+woeid+%3D151582&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
        //http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text%3D%2237.416275%2C-122.025092%22%20and%20gflags%3D%22R%22&format=json
        
        NSURL *url = [NSURL URLWithString:urlStr];
      //======================================================================
        cdQuery.url = [url absoluteString];
      //======================================================================
        query.url = url;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setTimeoutInterval:30];
        
        //    [NSURLConnection sendAsynchronousRequest:request
        //                                               queue:[NSOperationQueue mainQueue]
        //                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //
        //                                       NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //
        //                                       NSLog(@"response: %@", responseStr);
        //                                       NSError *jsonError;
        //                                       NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        //
        //
        //                                       if (jsonError == nil) {
        //                                           NSDictionary *queryDict = dataDictionary[@"query"];
        //                                           NSDictionary *results = queryDict[@"results"];
        //                                           NSDictionary *channel = results[@"channel"];
        //                                           NSDictionary *item = channel[@"item"];
        //                                           NSDictionary *condition = item[@"condition"];
        //                                           NSString *text = condition[@"text"];
        //
        //                                           query.text = text;
        //                                           [self.queries addObject:query];
        //                                           [self.tableView reloadData];
        //                                       }
        //
        //                                   }];
        
        NSURLResponse *response;
        NSError *syncError;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&syncError];
        if (syncError == nil) {
            NSError *jsonError;
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&jsonError];
            
            
            if (jsonError == nil) {
                NSDictionary *queryDict = dataDictionary[@"query"];
                NSDictionary *results = queryDict[@"results"];
                NSDictionary *channel = results[@"channel"];
                NSDictionary *item = channel[@"item"];
                NSDictionary *condition = item[@"condition"];
                NSString *text = condition[@"text"];
      //======================================================================
                cdQuery.text = text;
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
      //======================================================================
                query.text = text;
                //[self.queries addObject:query];
      //======================================================================
                [self.queries addObject:cdQuery];
      //======================================================================
                [self performSelectorOnMainThread:@selector(downloadFinished:)
                                       withObject:query
                                    waitUntilDone:NO];
            }
        }
        
    }
}

- (void)downloadFinished:(id)object {
    // Main
    [self.tableView reloadData];
}

/*
 {
 "query": {
 "count": 1,
 "created": "2014-12-18T14:40:08Z",
 "lang": "en-us",
 "results": {
 "Result": {
 "quality": "87",
 "addressMatchType": "INTERPOLATED",
 "latitude": "37.416275",
 "longitude": "-122.025092",
 "offsetlat": "37.416275",
 "offsetlon": "-122.025092",
 "radius": "400",
 "name": "37.416275,-122.025092",
 "line1": "1361 N Mathilda Ave",
 "line2": "Sunnyvale, CA 94089",
 "line3": null,
 "line4": "United States",
 "house": "1361",
 "street": "N Mathilda Ave",
 "xstreet": null,
 "unittype": null,
 "unit": null,
 "postal": "94089",
 "neighborhood": null,
 "city": "Sunnyvale",
 "county": "Santa Clara County",
 "state": "California",
 "country": "United States",
 "countrycode": "US",
 "statecode": "CA",
 "countycode": null,
 "uzip": "94089",
 "hash": "5074F43198101435",
 "woeid": "12797150",
 "woetype": "11"
 }
 }
 }
 }
 */

#pragma mark - UITableViewDelegate and DataSource implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.queries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }
    
    Query *query = self.queries[indexPath.row];
    cell.textLabel.text = query.woeid;
    cell.detailTextLabel.text = query.text;
    
    return cell;
}


//151582

@end






