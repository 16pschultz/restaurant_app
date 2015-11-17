//
//  RewardsVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/23/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColorOne;
@property (strong, nonatomic) UIColor  *resColorTwo;

@property (strong, nonatomic) IBOutlet UITableView *tableViewRewards;

@property (strong, nonatomic) NSArray *rewardsArray;
@property (strong, nonatomic) NSString *myPlaceHolder;

@property (strong, nonatomic) IBOutlet UILabel *userPoints;

@end
