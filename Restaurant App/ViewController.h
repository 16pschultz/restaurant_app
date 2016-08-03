//
//  ViewController.h
//  Restaurant App
//
//  Created by Peter Schultz on 6/18/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSTimer *timer;
}

// Testing
@property (strong, nonatomic) NSArray *mealTypesArray;




#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@property (strong, nonatomic) NSArray *restaurantObjects;
@property (strong, nonatomic) IBOutlet UIImageView *resLogo;

@property (strong, nonatomic) NSData *picData;

// Deal TVC
@property (strong, nonatomic) IBOutlet UITableView *tvDeal;
@property (nonatomic, retain) NSMutableArray *imageFiles;

@property (nonatomic, retain) NSArray *dealListArray;

// Redeem View
@property (strong, nonatomic) IBOutlet UIView *viewRedeeming;
@property (strong, nonatomic) IBOutlet UILabel *oDeal;
@property (strong, nonatomic) IBOutlet UILabel *oRuntime;
@property (strong, nonatomic) IBOutlet UILabel *oExpiration;
- (IBAction)dismissRedeeming;
@property (weak, nonatomic) IBOutlet UIButton *oRedeem;
- (IBAction)redeemButton;
@property (weak, nonatomic) IBOutlet UILabel *messageRedeem;


// Timer after Redeeming
@property (nonatomic, assign) int time;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int seconds;

// All Restaurant Data
@property (strong, nonatomic) NSObject *resDealsUsed;
@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) NSString *resName;
@property (strong, nonatomic) NSString *resLocation;
@property (strong, nonatomic) NSNumber *resPhoneNum;
@property (strong, nonatomic) NSNumber *resLongitude;
@property (strong, nonatomic) NSNumber *resLatitude;
@property (strong, nonatomic) NSString *stringColor;
@property (strong, nonatomic) NSString *colorShade;
@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

- (IBAction)MakePhoneCall:(id)sender;

- (IBAction)menuButton;
- (IBAction)directionsButton;
- (IBAction)appDealsButton;


@property (strong, nonatomic) IBOutlet UIButton *buttonMenu;
@property (strong, nonatomic) IBOutlet UIButton *buttonAppDeals;
@property (strong, nonatomic) IBOutlet UIButton *buttonDirections;
@property (strong, nonatomic) IBOutlet UIButton *buttonCall;

@property (strong, nonatomic) IBOutlet UILabel *labelResName;


@end

