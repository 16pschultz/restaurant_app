//
//  DealVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/28/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealVC : UIViewController

// Strings
@property (strong, nonatomic) NSString *stringImage;
@property (strong, nonatomic) NSString *stringDescription;
@property (strong, nonatomic) NSString *stringDiscount;

// Outlets
@property (strong, nonatomic) IBOutlet UIImageView *dealImage;
@property (strong, nonatomic) IBOutlet UILabel *dealDescription;
@property (strong, nonatomic) IBOutlet UILabel *dealDiscount;
@property (weak, nonatomic) IBOutlet UIButton *oRedeemButton;


- (IBAction)redeemButton:(id)sender;

@end
