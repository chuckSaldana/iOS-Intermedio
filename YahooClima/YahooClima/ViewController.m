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
#import "YCClimaCell.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetWoeidNotification:)
                                                 name:@"didGetWoeid"
                                               object:nil];
    
    self.locationHelper = [[YCLocationHelper alloc] init];
    [self.locationHelper startGettingLocation];
}

- (void)didGetWoeidNotification:(NSNotification *)notification {
    NSString *woeid = notification.object;
    NSString *city = notification.userInfo[@"city"];
    NSDictionary *info = @{@"woeid" : woeid, @"city" : city};
    [self performSelectorInBackground:@selector(downloadData:) withObject:info];
}

- (IBAction)queryButtonTapped:(id)sender {
    [self.queryTxt resignFirstResponder];
    NSString *city = @"Zapopan";
    NSDictionary *info = @{@"woeid" : self.queryTxt.text, @"city" : city};
    [self performSelectorInBackground:@selector(downloadData:) withObject:info];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadData:(NSDictionary *)info {
    @autoreleasepool {
      //======================================================================
        NSEntityDescription *description = [NSEntityDescription entityForName:@"Query"
                                                       inManagedObjectContext:self.context];
        Query *cdQuery = [[Query alloc] initWithEntity:description
                        insertIntoManagedObjectContext:self.context];
        cdQuery.woeid = info[@"woeid"];
        cdQuery.city = info[@"city"];
      //======================================================================
        
        
        __block YCQuery *query = [[YCQuery alloc] init];
        query.woeid = info[@"woeid"];
        
        NSString *urlStr = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select+item.condition+from+weather.forecast+where+woeid+%%3D%@&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys", query.woeid];
        
        NSURL *url = [NSURL URLWithString:urlStr];
      //======================================================================
        cdQuery.url = [url absoluteString];
      //======================================================================
        query.url = url;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setTimeoutInterval:30];
 
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


#pragma mark - UITableViewDelegate and DataSource implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.queries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    YCClimaCell *cell = (YCClimaCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"YCClimaCell"
                                                       owner:self
                                                     options:nil];
        cell = [items lastObject];
    }
    
    Query *query = self.queries[indexPath.row];
    
    cell.oweidLbl.text = query.woeid;
    cell.pronosticoLbl.text = query.text;
    cell.ciudadLbl.text = query.city;
    
    if ([cell.pronosticoLbl.text rangeOfString:@"Sunny"].length > 0) {
        cell.imagen.image = [UIImage imageNamed:@"sunny"];
    }
    else if ([cell.pronosticoLbl.text rangeOfString:@"Cloudy"].length > 0) {
        cell.imagen.image = [UIImage imageNamed:@"cloudy"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 92;
}


//151582

@end














