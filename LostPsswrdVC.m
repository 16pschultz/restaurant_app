//
//  LostPsswrdVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/28/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "LostPsswrdVC.h"
#import <Parse/Parse.h>


@interface LostPsswrdVC ()

@end

@implementation LostPsswrdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.outletEmailTF.delegate = self;
    
    [[self.oSendButton layer] setBorderWidth:0.7f];
    [[self.oSendButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:NO];
    
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;

}


- (IBAction)sendEmailButton {
    
    self.stringEmailAddress = [self.outletEmailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.stringEmailAddress length] == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a valid Username & Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    } else {
        
                
            [PFUser requestPasswordResetForEmailInBackground:self.stringEmailAddress
                                                           block:^(BOOL succeeded, NSError *error) {
                                                               if (succeeded)
                                                               {
                                                                   NSLog(@"Reset Successful!");
                                                                   self.outletEmailTF.text = @"";
                                                                   self.outletLabel.text = @"Password reset has been sent!";
                                                               }
                                                               else
                                                               {
                                                                   NSLog(@"Reset Unsuccessful!");
                                                                   self.outletLabel.text = @"Email Address unrecognized!";
                                                               }
                                                           }];

    }
}


#pragma UITextField Dismissing Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}




@end
