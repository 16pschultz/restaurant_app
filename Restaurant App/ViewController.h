//
//  ViewController.h
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@property (strong, nonatomic) NSArray *restaurantObjects;

// All Restaurant Data
@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) NSString *resName;
@property (strong, nonatomic) NSString *resLocation;
@property (strong, nonatomic) NSNumber *resPhoneNum;
@property (strong, nonatomic) NSNumber *resLongitude;
@property (strong, nonatomic) NSNumber *resLatitude;
@property (strong, nonatomic) NSString *stringColor;
@property (strong, nonatomic) UIColor  *resColor;


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


@property (strong, nonatomic) IBOutlet UIButton *buttonMenu;
@property (strong, nonatomic) IBOutlet UIButton *buttonAppDeals;
@property (strong, nonatomic) IBOutlet UIButton *buttonDirections;
@property (strong, nonatomic) IBOutlet UIButton *buttonScan;
@property (strong, nonatomic) IBOutlet UIButton *buttonRewards;
@property (strong, nonatomic) IBOutlet UIButton *buttonCall;
@property (strong, nonatomic) IBOutlet UILabel *labelResName;


@end

