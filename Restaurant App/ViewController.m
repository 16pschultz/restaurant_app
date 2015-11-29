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

NSString *const kRedBC = @"redBC";
NSString *const kWhiteBC = @"whiteBC";


@interface ViewController ()

@end

#define TAG_CALL 1
#define TAG_LOGIN 2

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self convHex];
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
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.buttonMenu.backgroundColor = [UIColor whiteColor];
    self.buttonScan.backgroundColor = [UIColor whiteColor];
    self.buttonRewards.backgroundColor = [UIColor whiteColor];
    
    self.buttonAppDeals.backgroundColor = self.resColor;
    [self.buttonAppDeals.imageView setImage:[UIImage imageNamed:@"appDealsIcon.png"]];
    [self.buttonAppDeals.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.buttonDirections.backgroundColor = self.resColor;
    self.buttonCall.backgroundColor = self.resColor;
    
    self.labelResName.text = self.resName;
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
        appDealsTVC.resColor = self.resColor;
    }
    
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        
        MenuTVC *menuTVC = (MenuTVC *)segue.destinationViewController;
        menuTVC.resObjectId = self.resObjectId;
        menuTVC.resColor = self.resColor;
    }
    
    if ([segue.identifier isEqualToString:@"showDirections"]) {
        
        MapVC *mapVC = (MapVC *)segue.destinationViewController;
        mapVC.resObjectId = self.resObjectId;
        mapVC.resColor = self.resColor;
        mapVC.resLatitude = self.resLatitude;
        mapVC.resLongitude = self.resLongitude;
    }
    
    if ([segue.identifier isEqualToString:@"showRewards"]) {
        
        RewardsVC *rewardsVC = (RewardsVC *)segue.destinationViewController;
        rewardsVC.resObjectId = self.resObjectId;
        rewardsVC.resColor = self.resColor;
    }
    
    if ([segue.identifier isEqualToString:@"showScan"]) {
        
        QRCodeVC *qrCodeVC = (QRCodeVC *)segue.destinationViewController;
        qrCodeVC.resObjectId = self.resObjectId;
        qrCodeVC.resColor = self.resColor;
    }
}

- (void) convHex {
    
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self.stringColor];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&result];
    self.resColor = UIColorFromRGB(result);
}

@end
