//
//  DealVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/28/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "DealVC.h"
#import "AppDealsTVC.h"
#import <Parse/Parse.h>

@interface DealVC ()

@end

@implementation DealVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.time = 120;
    
    [[self.dealImage layer] setBorderWidth:0.7f];
    [[self.dealImage layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.oRedeemButton layer] setBorderWidth:1.0f];
    [[self.oRedeemButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    self.dealImage.image = [UIImage imageNamed:self.stringImage];
    self.dealDescription.text = self.stringDescription;
    self.dealDiscount.text = self.stringDiscount;
    self.dealDDiscount.text = self.stringDiscount;
    self.dealTitle.text = self.stringDescription;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)exitViewButton {
    
    self.navigationItem.hidesBackButton = NO;
    self.outletViewRedeeming.hidden = YES;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (IBAction)redeemButton:(id)sender {
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Redeem?"
                                                    message:@"Show to your waiter when redeeming"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    
//    [[PFUser currentUser] removeObjectsInArray:[1] forKey:@"Deals";
//    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"The object has been saved.");
//        } else {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];

}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        // Cancel was Tapped
        
    }else{

        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
        
        self.navigationItem.hidesBackButton = YES;
        self.outletViewRedeeming.hidden = NO;
        
        [self.oRedeemButton setBackgroundColor:[UIColor colorWithRed:25/255.0 green:191/255.0 blue:0/255.0 alpha:1]];
        [self.oRedeemButton setTitle:@"Redeemed!" forState:UIControlStateNormal];
        [self.oRedeemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.oRedeemButton setEnabled:NO];
        
        [[self.oRedeemButton layer] setBorderWidth:1.0f];
        [[self.oRedeemButton layer] setBorderColor:[UIColor whiteColor].CGColor];
        
    }
}



- (void)countdown {

    self.time -= 1;
    
    self.seconds = self.time % 60;
    self.minutes = (self.time - self.seconds) / 60;
    self.outletTimer.text = [NSString stringWithFormat:@"%d:%.2d", self.minutes, self.seconds];
    
    NSString *padZero = @"";
    
    if(self.seconds < 10) padZero = @"0";
    
    self.outletTimer.text = [NSString stringWithFormat:@"%i:%@%i", self.minutes , padZero, self.seconds];
    
    if (self.time == 0) {
        
        [timer invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }
}






@end
