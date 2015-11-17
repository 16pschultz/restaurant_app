//
//  ViewController.m
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "ViewController.h"

#import "AppDealsTVC.h"
#import "MenuTVC.h"
#import "RewardsVC.h"
#import "MapVC.h"
#import "QRCodeVC.h"

#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

NSString *const kRedBC = @"redBC";
NSString *const kWhiteBC = @"whiteBC";


@interface ViewController ()

@end

#define TAG_CALL 1
#define TAG_LOGIN 2

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeColor];
    [self reloadInputViews];
}


- (void) viewDidAppear:(BOOL)animated {
    
    if ([PFUser currentUser]) {
        
        [self.outletSignInButton setHidden:YES];
        [self.outletSignOutButton setHidden:NO];
        
    } else if (![PFUser currentUser]) {
        
        [self.outletSignInButton setHidden:NO];
        [self.outletSignOutButton setHidden:YES];
    }
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = self.resColorTwo;
    self.navigationController.navigationBar.tintColor = self.resColorOne;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : self.resColorOne}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.buttonMenu.backgroundColor = self.resColorOne;
    self.buttonScan.backgroundColor = self.resColorOne;
    self.buttonRewards.backgroundColor = self.resColorOne;
    
    self.buttonAppDeals.backgroundColor = self.resColorTwo;
    self.buttonDirections.backgroundColor = self.resColorTwo;
    self.buttonCall.backgroundColor = self.resColorTwo;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
    } else if (alertView.tag == TAG_LOGIN){
        [PFUser logOut];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    }];
}

- (IBAction)MakePhoneCall:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Call" message:[NSString stringWithFormat:@"Call %@?", self.resName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    
    alertView.tag = TAG_CALL;
    [alertView show];
}



- (IBAction)SignOutButton {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];

    alertView.tag = TAG_LOGIN;
    [alertView show];

}


- (IBAction)SignInButton {
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];

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


- (IBAction)rewardsButton {
    
    if (![PFUser currentUser]) {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];
        
    } else if ([PFUser currentUser]) {
        
        // Launch Rewards Page
        [self performSegueWithIdentifier:@"showRewards" sender:self];
    }
}

- (IBAction)scanButton {
    
    if (![PFUser currentUser]) {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];
        
    } else if ([PFUser currentUser]) {
        
        // Launch Scan Page
        [self performSegueWithIdentifier:@"showScan" sender:self];
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAppDeals"]) {
        
        AppDealsTVC *appDealsTVC = (AppDealsTVC *)segue.destinationViewController;        
        appDealsTVC.resObjectId = self.resObjectId;
        appDealsTVC.resColorOne = self.resColorOne;
        appDealsTVC.resColorTwo = self.resColorTwo;
    }
    
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        
        MenuTVC *menuTVC = (MenuTVC *)segue.destinationViewController;
        menuTVC.resObjectId = self.resObjectId;
        menuTVC.resColorOne = self.resColorOne;
        menuTVC.resColorTwo = self.resColorTwo;
    }
    
    if ([segue.identifier isEqualToString:@"showDirections"]) {
        
        MapVC *mapVC = (MapVC *)segue.destinationViewController;
        mapVC.resObjectId = self.resObjectId;
        mapVC.resColorOne = self.resColorOne;
        mapVC.resColorTwo = self.resColorTwo;
        mapVC.resLatitude = self.resLatitude;
        mapVC.resLongitude = self.resLongitude;
    }
    
    if ([segue.identifier isEqualToString:@"showRewards"]) {
        
        RewardsVC *rewardsVC = (RewardsVC *)segue.destinationViewController;
        rewardsVC.resObjectId = self.resObjectId;
        rewardsVC.resColorOne = self.resColorOne;
        rewardsVC.resColorTwo = self.resColorTwo;
    }
    
    if ([segue.identifier isEqualToString:@"showScan"]) {
        
        QRCodeVC *qrCodeVC = (QRCodeVC *)segue.destinationViewController;
        qrCodeVC.resObjectId = self.resObjectId;
        qrCodeVC.resColorOne = self.resColorOne;
        qrCodeVC.resColorTwo = self.resColorTwo;
    }
}


- (void) makeColor {

        // Restaurant Colors
        NSNumber *color_one1 = self.colorArray1[0];
        NSNumber *color_one2 = self.colorArray1[1];
        NSNumber *color_one3 = self.colorArray1[2];
        
        NSNumber *color_two1 = self.colorArray2[0];
        NSNumber *color_two2 = self.colorArray2[1];
        NSNumber *color_two3 = self.colorArray2[2];
        
        
        int c1_1 = color_one1.intValue;
        int c1_2 = color_one2.intValue;
        int c1_3 = color_one3.intValue;
        
        int c2_1 = color_two1.intValue;
        int c2_2 = color_two2.intValue;
        int c2_3 = color_two3.intValue;
        
        
        self.resColorOne = [UIColor colorWithRed:c1_1/255.0f
                                           green:c1_2/255.0f
                                            blue:c1_3/255.0f alpha:1];
        
        self.resColorTwo = [UIColor colorWithRed:c2_1/255.0f
                                           green:c2_2/255.0f
                                            blue:c2_3/255.0f alpha:1];
}

@end
