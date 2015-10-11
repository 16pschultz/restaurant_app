//
//  AppDealsTVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "AppDealsTVC.h"
#import "DealVC.h"
#import <QuartzCore/CALayer.h>
#import <Parse/Parse.h>

@interface AppDealsTVC ()

@end

@implementation AppDealsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    NSArray *myDeals = [[NSUserDefaults standardUserDefaults] objectForKey:@"DealKey"];

    return [myDeals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    PFQuery *query = [PFUser query];
//    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *appDeals, NSError *error) {
//        
//        NSString *CellIdentifier = @"Cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        self.dealList = [appDeals objectForKey:@"Deals"];
//
//        // Item Name
//        cell.textLabel.text = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"deal"];
//        cell.textLabel.numberOfLines = 3;
//        // Line Breaking
//        cell.textLabel.textColor = [UIColor blackColor];
//        cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
//        
//        // Item Price
//        cell.detailTextLabel.text = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"discount"];
//        cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
//        cell.detailTextLabel.textColor = [UIColor blackColor];
//        
//        // Item Image
//        self.stringPlaceholder = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"dimage"];
//        cell.imageView.image = [UIImage imageNamed:self.stringPlaceholder];
//        [cell.imageView.layer setBorderWidth:1.4f];
//        [cell.imageView.layer setBorderColor:[UIColor redColor].CGColor];
//        
//        
//        // Cell and Background Attributes
//        cell.backgroundColor = [UIColor whiteColor];
//        self.view.backgroundColor = [UIColor whiteColor];
//        
//        // Navigation Bar Attibutes
//        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [self.navigationController.navigationBar
//         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//        self.navigationController.navigationBar.translucent = NO;
//        
//        // TableView Separator
//        [self.tableView setSeparatorColor:[UIColor redColor]];
//        
//        // Rounded Image
//        CALayer *cellImageLayer = cell.imageView.layer;
//        [cellImageLayer setCornerRadius:7];
//        [cellImageLayer setMasksToBounds:YES];
//        
//        return cell;
//    }];
    
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *appDeals;
    self.dealList = [appDeals objectForKey:@"Deals"];
    
    // Item Name
    cell.textLabel.text = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"deal"];
    cell.textLabel.numberOfLines = 3;
    // Line Breaking
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"discount"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    // Item Image
    self.stringPlaceholder = [[self.dealList objectAtIndex:indexPath.row] objectForKey:@"dimage"];
    cell.imageView.image = [UIImage imageNamed:self.stringPlaceholder];
    [cell.imageView.layer setBorderWidth:1.4f];
    [cell.imageView.layer setBorderColor:[UIColor redColor].CGColor];
    
    
    // Cell and Background Attributes
    cell.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    // TableView Separator
    [self.tableView setSeparatorColor:[UIColor redColor]];
    
    // Rounded Image
    CALayer *cellImageLayer = cell.imageView.layer;
    [cellImageLayer setCornerRadius:7];
    [cellImageLayer setMasksToBounds:YES];
    
    return cell;

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDeal"]) {
        
        PFQuery *query = [PFUser query];
        [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *appDeals, NSError *error) {
            
        self.dealList = [appDeals objectForKey:@"Deals"];
            
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dealList = [[self.dealList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        DealVC *dealVC = (DealVC *)segue.destinationViewController;
        
        dealVC.stringImage = [dealList objectForKey:@"dimage"];
        dealVC.stringDescription = [dealList objectForKey:@"deal"];
        dealVC.stringDiscount = [dealList objectForKey:@"discount"];

        }];
    }
}


@end
