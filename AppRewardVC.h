//
//  AppRewardVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 8/16/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppRewardVC : UIViewController

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColorOne;
@property (strong, nonatomic) UIColor  *resColorTwo;

@property (nonatomic, retain) NSNumber *point2Redeem;
@property (nonatomic, retain) NSString *rewardDescription;
@property (nonatomic, retain) NSString *rewardCost;

@property (weak, nonatomic) IBOutlet UILabel *oRewardDescription;
@property (weak, nonatomic) IBOutlet UILabel *oRewardCost;
@property (weak, nonatomic) IBOutlet UIButton *oRedeemButton;

- (IBAction)redeemButton:(id)sender;

@end
