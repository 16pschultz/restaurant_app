//
//  RewardsVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/23/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "RewardsVC.h"
#import <Parse/Parse.h>
#import "AppRewardVC.h"

@interface RewardsVC ()

@end

@implementation RewardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [self queryForRewards];
    [self pointsForReward];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [[self.tableViewRewards layer] setBorderWidth:1.5f];
    [[self.tableViewRewards layer] setBorderColor:self.resColor.CGColor];
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    self.tableViewRewards.layer.cornerRadius = 7;
    self.tableViewRewards.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [self.rewardsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.userPoints < [self.rewardsArray objectAtIndex:indexPath.row][@"cost"]) {
        
        cell.userInteractionEnabled = NO;
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
        
    } else {
        
        cell.userInteractionEnabled = YES;
        cell.textLabel.enabled = YES;
        cell.detailTextLabel.enabled = YES;
    }
    
    // Item Name
    cell.textLabel.text = [self.rewardsArray objectAtIndex:indexPath.row][@"reward"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Points", [self.rewardsArray objectAtIndex:indexPath.row][@"cost"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
//     TableView Separator
    [self.tableViewRewards setSeparatorColor:self.resColor];
    
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAppReward"]) {
        
        NSIndexPath *indexPath = [self.tableViewRewards indexPathForSelectedRow];
        
        AppRewardVC *appRewardVC = (AppRewardVC *)segue.destinationViewController;
        
        appRewardVC.rewardDescription = [self.rewardsArray objectAtIndex:indexPath.row][@"reward"];
        appRewardVC.rewardCost = [self.rewardsArray objectAtIndex:indexPath.row][@"cost"];
    }
}

- (void) pointsForReward {

    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId block:^(PFObject *userInfo, NSError *error) {
        
        self.userPoints = [userInfo objectForKey:@"points"];
        self.userName = [userInfo objectForKey:@"username"];
        self.currentUserPoints.text = [NSString stringWithFormat:@"Your Points: %@", self.userPoints];
        [self.tableViewRewards reloadData];
    }];
}

- (void) queryForRewards {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reward"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query orderByAscending:@"cost"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.rewardsArray = objects;
        [self.tableViewRewards reloadData];
    }];
}



@end
