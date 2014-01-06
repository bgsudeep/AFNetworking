//
//  ViewController.m
//  workForAFNetworking
//
//  Created by ATI on 1/6/14.
//  Copyright (c) 2014 ATI. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize results = _results;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.results = [[NSArray alloc]initWithObjects:@"one", @"two", nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://maps.googleapis.com/maps/api/place/textsearch/json?&location=27.674426,85.312329&radius=500&query=bank&name=bank&sensor=true&key=AIzaSyCoqmMsxkwMajuPF-OGy8d5BOMctN6qGbw" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Response: %@", responseObject);
        
        
        self.results = [responseObject objectForKey:@"results"];
        NSLog(@"This is a first one: %@", self.results[0]);
        [_tableView reloadData];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
    NSDictionary *party = [self.results objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [party objectForKey:@"name"];
    cell.detailTextLabel.text = [party objectForKey:@"formatted_address"];
    
    NSString *imageURL = [party objectForKey:@"icon"];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
    
    return cell;
}



@end
