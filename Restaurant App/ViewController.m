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

NSString *const kRedBC = @"redBC";
NSString *const kWhiteBC = @"whiteBC";


@interface ViewController ()

@end

#define TAG_CALL 1
#define TAG_LOGIN 2

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self queryForBC];
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
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *resNum, NSError *error) {
        
    NSNumber *telNum = [resNum objectForKey:@"phoneNum"];
    
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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Cape Up B&R?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    
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

- (void) queryForBC {
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *colors, NSError *error) {
        
        NSArray *colorArray1;
        NSArray *colorArray2;
        
        colorArray1 = [colors objectForKey:@"colorOne"];
        colorArray2 = [colors objectForKey:@"colorTwo"];
        
        NSNumber *color_one1 = colorArray1[0];
        NSNumber *color_one2 = colorArray1[1];
        NSNumber *color_one3 = colorArray1[2];
        
        NSNumber *color_two1 = colorArray2[0];
        NSNumber *color_two2 = colorArray2[1];
        NSNumber *color_two3 = colorArray2[2];
        
        
        int c1_1 = color_one1.intValue;
        int c1_2 = color_one2.intValue;
        int c1_3 = color_one3.intValue;
        
        int c2_1 = color_two1.intValue;
        int c2_2 = color_two2.intValue;
        int c2_3 = color_two3.intValue;
        
        
        UIColor *clr1 = [UIColor colorWithRed:c1_1/255.0f
                                        green:c1_2/255.0f
                                         blue:c1_3/255.0f alpha:1];
        
        UIColor *clr2 = [UIColor colorWithRed:c2_1/255.0f
                                        green:c2_2/255.0f
                                         blue:c2_3/255.0f alpha:1];
        
        
        self.buttonMenu.backgroundColor = clr1;
        self.buttonScan.backgroundColor = clr1;
        self.buttonRewards.backgroundColor = clr1;
        
        self.buttonAppDeals.backgroundColor = clr2;
        self.buttonDirections.backgroundColor = clr2;
        self.buttonCall.backgroundColor = clr2;
        
    }];
}

@end
