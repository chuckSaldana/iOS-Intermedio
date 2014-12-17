//
//  ViewController.m
//  YahooClima
//
//  Created by Apocalapsus on 12/17/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import "ViewController.h"
#import "YCQuery.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *queries;
@property (weak, nonatomic) IBOutlet  UITextField *queryTxt;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.queries = [NSMutableArray array];
    
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
        
        __block YCQuery *query = [[YCQuery alloc] init];
        query.woeid = self.queryTxt.text;
        
        NSString *urlStr = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select+item.condition+from+weather.forecast+where+woeid+%%3D%@&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys", query.woeid];
        //https://query.yahooapis.com/v1/public/yql?q=select+item.condition+from+weather.forecast+where+woeid+%3D151582&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
        
        NSURL *url = [NSURL URLWithString:urlStr];
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
                
                query.text = text;
                [self.queries addObject:query];
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
 "created": "2014-12-17T17:17:14Z",
 "lang": "en-us",
 "results": {
 "channel": {
 "item": {
 "condition": {
 "code": "30",
 "date": "Wed, 17 Dec 2014 10:47 am CST",
 "temp": "68",
 "text": "Partly Cloudy"
 }
 }
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
    
    YCQuery *query = self.queries[indexPath.row];
    cell.textLabel.text = query.woeid;
    cell.detailTextLabel.text = query.text;
    
    return cell;
}


//151582

@end






