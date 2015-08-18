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

    [[self.dealImage layer] setBorderWidth:0.7f];
    [[self.dealImage layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.oRedeemButton layer] setBorderWidth:1.0f];
    [[self.oRedeemButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    self.dealImage.image = [UIImage imageNamed:self.stringImage];
    self.dealDescription.text = self.stringDescription;
    self.dealDiscount.text = self.stringDiscount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)redeemButton:(id)sender {
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Redeem"
                                                    message:@"Are you sure you want to redeem?"
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
        
//        PFQuery *query = [PFQuery queryWithClassName:@"Events"];
//        [query whereKey:@"usersIncluded" equalTo:[self.uniqeFriendList objectAtIndex:indexPath.row]];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//            for (int i = 0; i <objects.count; i++) {
//                PFObject *event = [objects objectAtIndex:i];    // note using 'objects', not 'eventObjects'
//                [event removeObject:[self.uniqeFriendList objectAtIndex:indexPath.row] forKey:@"usersIncluded"];
//            }
//            
//            [PFObject saveAll:objects];
//        }];
//        
        // Redeem Deal
        
    }
}
     
@end
