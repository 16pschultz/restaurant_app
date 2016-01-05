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
    
    PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
    PFFile *resLogo = restaurant[@"logo"];
    [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {

            self.picData = imageData;
            NSLog(@"%@", self.picData);
        } else if (error) {
            NSLog(@"There was an error");
        }
    }];
    
    [self convHex];
    [self reloadInputViews];
}


- (void) viewDidAppear:(BOOL)animated {
    
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
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
    
    [[self.buttonAppDeals layer] setBorderWidth:4.5f];
    [[self.buttonAppDeals layer] setBorderColor:self.resColor.CGColor];
    
    [[self.buttonMenu layer] setBorderWidth:4.5f];
    [[self.buttonMenu layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.buttonDirections layer] setBorderWidth:4.5f];
    [[self.buttonDirections layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.buttonCall layer] setBorderWidth:4.5f];
    [[self.buttonCall layer] setBorderColor:[UIColor whiteColor].CGColor];
    
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
}

- (void) convHex {
    
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self.stringColor];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&result];
    self.resColor = UIColorFromRGB(result);
}

@end
