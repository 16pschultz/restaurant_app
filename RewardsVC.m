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

NSString *const kReward = @"reward";
NSString *const kPoints = @"points";
NSString *const kNumber = @"number";

@interface RewardsVC ()

@end

@implementation RewardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.tableViewRewards layer] setBorderWidth:1.5f];
    [[self.tableViewRewards layer] setBorderColor:[UIColor redColor].CGColor];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
//    self.tableViewRewards.layer.cornerRadius = 7;
//    self.tableViewRewards.layer.masksToBounds = YES;

    self.rewardsArray = @[@{kReward: @"10% off entire meal",
                           kPoints: @"2 Points",
                           kNumber: @2,
                           },
                          @{kReward: @"One FREE Dessert",
                            kPoints: @"4 Points",
                            kNumber: @4,
                            },
                          @{kReward: @"One FREE Appetiser",
                            kPoints: @"6 Points",
                            kNumber: @6,
                            }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColorTwo;
    self.navigationController.navigationBar.tintColor = self.resColorOne;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : self.resColorOne}];
    self.navigationController.navigationBar.translucent = NO;
    
    // Presenting the User's points and not letting it equal less than 0 if any bug occurs.
    NSNumber *currentPoints = [PFUser currentUser][@"Points"];
    int usersPoints = currentPoints.intValue;
    NSLog(@"%@",currentPoints);
    
    if (usersPoints < 0) {
        
        currentPoints = @0;
        [[PFUser currentUser] setValue:@0 forKey:@"Points"];
        [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"The object has been saved.");
            }
        }];
        
        self.userPoints.text = [NSString stringWithFormat:@"Your Points: %@", currentPoints];
        [self.tableViewRewards reloadData];
    } else {
        
        self.userPoints.text = [NSString stringWithFormat:@"Your Points: %@", currentPoints];
        [self.tableViewRewards reloadData];
    }
    //
    [self.tableViewRewards reloadData];
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
    
    // Count, seen above, means it “counts” the amount of objects in the array, finds 3 (for example), and displays 3 cells
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *rewardItems = [self.rewardsArray objectAtIndex:indexPath.row];
    
    NSNumber *currentPoints = [PFUser currentUser][@"Points"];
    
    if (currentPoints < [rewardItems valueForKey:kNumber]) {
        
        cell.userInteractionEnabled = NO;
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
        
    } else {
        
        cell.userInteractionEnabled = YES;
        cell.textLabel.enabled = YES;
        cell.detailTextLabel.enabled = YES;
    }
    
    // Item Name
    cell.textLabel.text = [rewardItems objectForKey:kReward];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [rewardItems objectForKey:kPoints];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
//     TableView Separator
    [self.tableViewRewards setSeparatorColor:[UIColor darkGrayColor]];
    
    return cell;
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAppReward"]) {
        
        NSIndexPath *indexPath = [self.tableViewRewards indexPathForSelectedRow];
        NSDictionary *rewardItems = [self.rewardsArray objectAtIndex:indexPath.row];
        
        AppRewardVC *appRewardVC = (AppRewardVC *)segue.destinationViewController;
        
        appRewardVC.point2Redeem = [rewardItems valueForKey:kNumber];
        appRewardVC.rewardDescription = [rewardItems objectForKey:kReward];
        appRewardVC.rewardCost = [rewardItems objectForKey:kPoints];
    }
}

@end
