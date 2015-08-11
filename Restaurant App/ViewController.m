//
//  ViewController.m
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

#define TAG_DEV 1
#define TAG_DONATE 2

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
 
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
    
    [self.navigationController.navigationBar setHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.cancelButtonIndex == buttonIndex){
        // Do cancel
        
    } else if (alertView.tag == TAG_DEV) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4107473748"]];
        
    } else if (alertView.tag == TAG_DONATE){
        [PFUser logOut];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (IBAction)MakePhoneCall:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Cape Up B&R?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    
    alertView.tag = TAG_DEV;
    [alertView show];

}



- (IBAction)SignOutButton {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];

    alertView.tag = TAG_DONATE;
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


@end
