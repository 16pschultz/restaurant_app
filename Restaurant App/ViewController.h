//
//  ViewController.h
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)MakePhoneCall:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *outletSignOutButton;
@property (strong, nonatomic) IBOutlet UIButton *outletSignInButton;

- (IBAction)SignOutButton;
- (IBAction)SignInButton;

- (IBAction)menuButton;
- (IBAction)directionsButton;

- (IBAction)appDealsButton;
- (IBAction)rewardsButton;
- (IBAction)scanButton;

@end

