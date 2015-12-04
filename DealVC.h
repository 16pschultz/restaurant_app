//
//  DealVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/28/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealVC : UIViewController {
    NSTimer *timer;
}

@property (nonatomic, assign) int option;

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;

// Strings
@property (strong, nonatomic) NSString *stringImage;
@property (strong, nonatomic) NSString *stringDeal;
@property (strong, nonatomic) NSString *stringRuntime;
@property (strong, nonatomic) NSString *stringExpiration;


// Outlets
@property (strong, nonatomic) IBOutlet UILabel *oDeal;
@property (strong, nonatomic) IBOutlet UILabel *oRuntime;
@property (strong, nonatomic) IBOutlet UILabel *oExpiration;
@property (strong, nonatomic) IBOutlet UIImageView *oImage;


@property (strong, nonatomic) IBOutlet UIButton *oRedeemButton;

// Two Views depending if Image is NULL
@property (strong, nonatomic) IBOutlet UIView *viewNoImage;
@property (strong, nonatomic) IBOutlet UIView *viewYesImage;

// View after Redeeming
@property (weak, nonatomic) IBOutlet UIView *outletViewRedeeming;
@property (weak, nonatomic) IBOutlet UILabel *outletTimer;

@property (nonatomic, assign) int time;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int seconds;

- (IBAction)exitViewButton;

- (IBAction)redeemButton:(id)sender;

@end
