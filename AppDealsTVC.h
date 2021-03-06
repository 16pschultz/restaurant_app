//
//  AppDealsTVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealVC.h"
#import <QuartzCore/CALayer.h>
#import <Parse/Parse.h>

@interface AppDealsTVC : UITableViewController {
    NSInteger rows;
}

// All Restaurant Data
@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

@property (nonatomic, retain) NSMutableArray *imageFiles;

@property (nonatomic, retain) NSArray *dealListArray;
@property (nonatomic, retain) NSString *dealTitle;
@property (nonatomic, retain) NSString *dealDiscount;
@property (nonatomic, retain) NSString *dealDescription;
@property (nonatomic, retain) NSString *stringPlaceholder;

@property (nonatomic, retain) NSDictionary *dealsDic;


@end

