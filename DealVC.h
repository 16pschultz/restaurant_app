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

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;

// Strings
@property (strong, nonatomic) NSString *stringImage;
@property (strong, nonatomic) NSString *stringDescription;
@property (strong, nonatomic) NSString *stringDiscount;

// Outlets
@property (strong, nonatomic) IBOutlet UIImageView *dealImage;
@property (strong, nonatomic) IBOutlet UILabel *dealDescription;
@property (strong, nonatomic) IBOutlet UILabel *dealDiscount;
@property (strong, nonatomic) IBOutlet UIButton *oRedeemButton;



// View after Redeeming
@property (weak, nonatomic) IBOutlet UIView *outletViewRedeeming;
@property (weak, nonatomic) IBOutlet UILabel *dealTitle;
@property (weak, nonatomic) IBOutlet UILabel *outletTimer;
@property (weak, nonatomic) IBOutlet UILabel *dealDDiscount;

@property (nonatomic, assign) int time;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int seconds;

- (IBAction)exitViewButton;


- (IBAction)redeemButton:(id)sender;

@end
