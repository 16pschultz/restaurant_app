//
//  ViewController.m
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "ViewController.h"

#import <UIKit/UIKit.h>

#import "AppDealsTVC.h"
#import "MenuTVC.h"
#import "RewardsVC.h"
#import "MapVC.h"
#import "QRCodeVC.h"

#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

#define TAG_CALL 1

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
//    PFFile *resLogo = restaurant[@"logo"];
//    [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//        if (!error) {
//
//            self.picData = imageData;
//            NSLog(@"%@", self.picData);
//        } else if (error) {
//            NSLog(@"There was an error");
//        }
//    }];
    
    [self convHex];
    [self queryForDeals];
    
}


- (void) viewDidAppear:(BOOL)animated {
    // every 30 seconds update nearest restaurant
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.viewRedeeming.hidden = YES;
    
    [[self.viewRedeeming layer] setBorderWidth:3.5f];
    [[self.viewRedeeming layer] setBorderColor:self.resColor.CGColor];
    
    [[self.oRedeem layer] setBorderWidth:2.5f];
    [[self.oRedeem layer] setBorderColor:self.resColor.CGColor];
    
    [[self.tvDeal layer] setBorderWidth:3.5f];
    [[self.tvDeal layer] setBorderColor:self.resColor.CGColor];
    
    if (self.colorShade == NULL) {
        self.offSetColor = [UIColor whiteColor];
        
    } else {
        self.offSetColor = [UIColor darkGrayColor];
        
        [self.buttonMenu setBackgroundImage:[UIImage imageNamed: @"menuPic_2.png"] forState:UIControlStateNormal];
        [self.buttonDirections setBackgroundImage:[UIImage imageNamed: @"directionsPic_2.png"] forState:UIControlStateNormal];
        [self.buttonCall setBackgroundImage:[UIImage imageNamed: @"call_2.png"] forState:UIControlStateNormal];
    }
    
    
    [self.navigationController.navigationBar setHidden:NO];
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = self.offSetColor;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : self.offSetColor}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.buttonMenu.backgroundColor = self.resColor;
    self.buttonDirections.backgroundColor = self.resColor;
    self.buttonCall.backgroundColor = self.resColor;
    
    [[self.buttonAppDeals layer] setBorderWidth:3.5f];
    [[self.buttonAppDeals layer] setBorderColor:self.resColor.CGColor];
    
    [[self.buttonMenu layer] setBorderWidth:3.5f];
    [[self.buttonMenu layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.buttonDirections layer] setBorderWidth:3.5f];
    [[self.buttonDirections layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.buttonCall layer] setBorderWidth:3.5f];
    [[self.buttonCall layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    self.labelResName.text = self.resName;
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

    NSLog(@"%lu", (unsigned long)[self.dealListArray count]);
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
    [formatter setDateFormat:@"MM-dd-yy"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@       Expires %@",[self.dealListArray objectAtIndex:indexPath.row][@"runTime"],[formatter stringFromDate:date]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
//    // Item Image
//    
//    PFFile *imageFile = [self.dealListArray objectAtIndex:indexPath.row][@"image"];
//    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//        if (!error) {
//            [self.imageFiles addObject:imageData];
//            [self.tvDeal reloadData];
//        }
//    }];
//    
//    [cell.imageView.layer setBorderWidth:1.4f];
//    [cell.imageView.layer setBorderColor:self.resColor.CGColor];
    
//    // Cell and Background Attributes
//    cell.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor whiteColor];
    
//    // Rounded Image
//    CALayer *cellImageLayer = cell.imageView.layer;
//    [cellImageLayer setCornerRadius:7];
//    [cellImageLayer setMasksToBounds:YES];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![PFUser currentUser]) {
        
        self.viewRedeeming.hidden = NO;
        self.oDeal.text = @"Must be logged in to Redeem";
        self.oRuntime.hidden = YES;
        self.oExpiration.hidden = YES;
        self.oRedeem.hidden = YES;
        self.messageRedeem.hidden = YES;
        
    } else if ([PFUser currentUser]) {
        
        self.viewRedeeming.hidden = NO;
        self.oDeal.text = [self.dealListArray objectAtIndex:indexPath.row][@"deal"];
        self.oRuntime.text = [self.dealListArray objectAtIndex:indexPath.row][@"runTime"];
        
        NSDate *date = [self.dealListArray objectAtIndex:indexPath.row][@"expirationDate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yy"];
        self.oExpiration.text = [NSString stringWithFormat:@"Expires %@", [formatter stringFromDate:date]];
    }
}





-(void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *resNum, NSError *error) {
        
    NSNumber *telNum = self.resPhoneNum;
    
    if (alertView.cancelButtonIndex == buttonIndex){
        // Do cancel
        
    } else if (alertView.tag == TAG_CALL) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", telNum]]];
    }
    }];
}

- (IBAction)MakePhoneCall:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Call" message:[NSString stringWithFormat:@"Call %@?", self.resName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    
    alertView.tag = TAG_CALL;
    [alertView show];
}


// Buttons on Home Screen

- (IBAction)menuButton {
    
    [self performSegueWithIdentifier:@"showMenu" sender:self];

}

- (IBAction)directionsButton {
    
    [self performSegueWithIdentifier:@"showDirections" sender:self];

}

- (IBAction)appDealsButton {
    
    if (![PFUser currentUser]) {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];

    } else if ([PFUser currentUser]) {
        
        // Launch App Deals Page
        [self performSegueWithIdentifier:@"showAppDeals" sender:self];
    }

}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAppDeals"]) {
        
        AppDealsTVC *appDealsTVC = (AppDealsTVC *)segue.destinationViewController;        
        appDealsTVC.resObjectId = self.resObjectId;
        appDealsTVC.resColor = self.resColor;
        appDealsTVC.offSetColor = self.offSetColor;
    }
    
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        
        MenuTVC *menuTVC = (MenuTVC *)segue.destinationViewController;
        menuTVC.resObjectId = self.resObjectId;
        menuTVC.resColor = self.resColor;
        menuTVC.offSetColor = self.offSetColor;
    }
    
    if ([segue.identifier isEqualToString:@"showDirections"]) {
        
        MapVC *mapVC = (MapVC *)segue.destinationViewController;
        mapVC.resObjectId = self.resObjectId;
        mapVC.resColor = self.resColor;
        mapVC.resLatitude = self.resLatitude;
        mapVC.resLongitude = self.resLongitude;
        mapVC.offSetColor = self.offSetColor;
    }
    
//    if ([segue.identifier isEqualToString:@"showDeal"]) {
//        
//        NSIndexPath *indexPath = [self.tvDeal indexPathForSelectedRow];
//        
//        NSDate *date = [self.dealListArray objectAtIndex:indexPath.row][@"expirationDate"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MM/dd/yy"];
//        
//        DealVC *dealVC = (DealVC *)segue.destinationViewController;
//        
//        //        dealVC.stringImage = [self.dealListArray objectAtIndex:indexPath.row][@"image"];
//        dealVC.stringDeal = [self.dealListArray objectAtIndex:indexPath.row][@"deal"];
//        dealVC.stringRuntime = [self.dealListArray objectAtIndex:indexPath.row][@"runTime"];
//        NSString *myDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
//        NSLog(@"%@", myDate);
//        dealVC.stringExpiration = [NSString stringWithFormat:@"Expires: %@",myDate];
//        dealVC.resColor = self.resColor;
//    }
}

- (void) queryForDeals {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Deal"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dealListArray = objects;
        NSLog(@"%@", self.dealListArray);
        [self.tvDeal reloadData];
    }];
}

- (void) convHex {
    
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self.stringColor];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&result];
    self.resColor = UIColorFromRGB(result);
}

- (IBAction)dismissRedeeming {
    
    self.viewRedeeming.hidden = YES;
    [self.oRedeem setBackgroundColor:[UIColor whiteColor]];
    [self.oRedeem setTitle:@"Redeemed" forState:UIControlStateNormal];
    [self.oRedeem setEnabled:YES];
}

- (IBAction)redeemButton {
    
    NSIndexPath *indexPath = [self.tvDeal indexPathForSelectedRow];
    
    [self.oRedeem setBackgroundColor:[UIColor greenColor]];
    [self.oRedeem setTitle:@"Redeemed!" forState:UIControlStateNormal];
    [self.oRedeem setEnabled:NO];
    
    self.oDeal.text = @"COUNTDOWN";
    self.oRuntime.text = [self.dealListArray objectAtIndex:indexPath.row][@"deal"];
    self.oExpiration.text = @"Show to waiter when Redeeming";
    
    [self queryForDeals];
    [self.tvDeal reloadData];
}

@end
