//
//  ViewController.h
//  workForAFNetworking
//
//  Created by ATI on 1/6/14.
//  Copyright (c) 2014 ATI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *results;

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
