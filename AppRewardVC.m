//
//  AppRewardVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 8/16/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "AppRewardVC.h"
#import <Parse/Parse.h>

@interface AppRewardVC ()

@end

@implementation AppRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.oRedeemButton layer] setBorderWidth:1.0f];
    [[self.oRedeemButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    self.oRewardDescription.text = self.rewardDescription;
    self.oRewardCost.text = [NSString stringWithFormat:@"Costs %@", self.rewardCost];
    
    NSLog(@"%@", self.point2Redeem);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColorTwo;
    self.navigationController.navigationBar.tintColor = self.resColorOne;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : self.resColorOne}];
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)redeemButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Redeem?"
                                                    message:[NSString stringWithFormat:@"This will withdraw %@ Points from your account", self.point2Redeem]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        // Cancel was Tapped
        
    }else{
        
        self.point2Redeem = @(-self.point2Redeem.doubleValue);
        NSLog(@"%@", self.point2Redeem);

        [[PFUser currentUser] incrementKey:@"Points" byAmount:self.point2Redeem];
        [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"%@, Points were taken from user's account", self.point2Redeem);
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"There was a problem");
            }
        }];
        
    }
}

@end
