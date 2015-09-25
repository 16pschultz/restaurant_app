//
//  AppDealsTVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDealsTVC : UITableViewController {
    NSInteger rows;
}

@property (nonatomic, retain) NSArray *dealList;

@property (nonatomic, retain) NSString *dealTitle;
@property (nonatomic, retain) NSString *dealDiscount;
@property (nonatomic, retain) NSString *dealDescription;
@property (nonatomic, retain) NSString *stringPlaceholder;

@property (nonatomic, retain) NSDictionary *dealsDic;


@end
