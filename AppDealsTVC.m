//
//  AppDealsTVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "AppDealsTVC.h"


@interface AppDealsTVC ()

@end

@implementation AppDealsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.imageFiles = [NSMutableArray new];
    
    [self queryForDeals];
    [self.tableView reloadData];
}



- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.tableView reloadData];
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

    return [self.dealListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Item Name
    cell.textLabel.text = [self.dealListArray objectAtIndex:indexPath.row][@"deal"];
    cell.textLabel.numberOfLines = 3;
    // Line Breaking
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    
    NSDate *date = [self.dealListArray objectAtIndex:indexPath.row][@"expirationDate"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yy"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@       Expires %@",[self.dealListArray objectAtIndex:indexPath.row][@"runTime"],[formatter stringFromDate:date]];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    // Item Image
    
    PFFile *imageFile = [self.dealListArray objectAtIndex:indexPath.row][@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            [self.imageFiles addObject:imageData];
            [self.tableView reloadData];
        }
    }];    
    
    [cell.imageView.layer setBorderWidth:1.4f];
    [cell.imageView.layer setBorderColor:self.resColor.CGColor];
    
    
    // Cell and Background Attributes
    cell.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // TableView Separator
    [self.tableView setSeparatorColor:self.resColor];
    
    // Rounded Image
    CALayer *cellImageLayer = cell.imageView.layer;
    [cellImageLayer setCornerRadius:7];
    [cellImageLayer setMasksToBounds:YES];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dealListArray objectAtIndex:indexPath.row][@"image"] == NULL) {
        
        [self performSegueWithIdentifier:@"showDeal" sender:self];
    } else {
        
        [self performSegueWithIdentifier:@"showDealWPic" sender:self];
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDeal"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        NSDate *date = [self.dealListArray objectAtIndex:indexPath.row][@"expirationDate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yy"];
        
        DealVC *dealVC = (DealVC *)segue.destinationViewController;
        
//        dealVC.stringImage = [self.dealListArray objectAtIndex:indexPath.row][@"image"];
        dealVC.stringDeal = [self.dealListArray objectAtIndex:indexPath.row][@"deal"];
        dealVC.stringRuntime = [self.dealListArray objectAtIndex:indexPath.row][@"runTime"];
        NSString *myDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        dealVC.stringExpiration = myDate;
        dealVC.resColor = self.resColor;
        
    }
}

- (void) queryForDeals {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Deal"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dealListArray = objects;
        
        [self.tableView reloadData];
    }];
}



@end
