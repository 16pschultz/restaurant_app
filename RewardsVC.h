//
//  RewardsVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/23/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

// User
@property (strong, nonatomic) NSNumber *userPoints;
@property (strong, nonatomic) NSString *userName;

// Restaurant Info
@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;


// TableView
@property (strong, nonatomic) IBOutlet UITableView *tableViewRewards;

@property (strong, nonatomic) NSArray *rewardsArray;
@property (strong, nonatomic) NSString *myPlaceHolder;

@property (strong, nonatomic) IBOutlet UILabel *currentUserPoints;

@end
