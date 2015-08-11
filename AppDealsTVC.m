//
//  AppDealsTVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "AppDealsTVC.h"
#import "DealVC.h"
#import <QuartzCore/CALayer.h>

NSString *const kDeal = @"deal";
NSString *const kDiscount = @"discount";
NSString *const kDImage = @"dimage";
NSString *const kDDescription = @"ddescription";

@interface AppDealsTVC ()

@end

@implementation AppDealsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    // Test
    
    self.dealListArray = [NSMutableArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"25% off Club Sandwich", kDeal, @"now $5.25", kDiscount, @"Club_San_RA.jpg", kDImage, @"Get 25% off our flavorful Club Sandwich!", kDDescription,
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Grilled Cheese", kDeal, @"FREE (read more)", kDiscount, @"grilled_cheese_RA.jpg", kDImage, @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!", kDDescription,
                           nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Club Sandwich w fries/chips", kDeal, @"FREE (read more)", kDiscount, @"Club_San_RA.jpg", kDImage, @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!", kDDescription,
                           nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                           @"25% off Club Sandwich", kDeal, @"now $5.25", kDiscount, @"Club_San_RA.jpg", kDImage, @"Get 25% off our flavorful Club Sandwich!", kDDescription,
                           nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Grilled Cheese", kDeal, @"FREE (read more)", kDiscount, @"grilled_cheese_RA.jpg", kDImage, @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!", kDDescription,
                           nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Club Sandwich w fries/chips", kDeal, @"FREE (read more)", kDiscount, @"Club_San_RA.jpg", kDImage, @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!", kDDescription,
                           nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Club Sandwich w fries/chips", kDeal, @"FREE (read more)", kDiscount, @"Club_San_RA.jpg", kDImage, @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!", kDDescription,
                          nil],
                      nil];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    /*
     Retrieve array data, return [parseArray count];
     */
    return [self.dealListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dealList = [self.dealListArray objectAtIndex:indexPath.row];
    /*
     Maybe NSDictionary *dealList = parseArray;
    */
    
    
    // Item Name
    cell.textLabel.text = [dealList objectForKey:kDeal];
    cell.textLabel.numberOfLines = 3;
// Line Breaking
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [dealList objectForKey:kDiscount];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    // Item Image
    self.stringPlaceholder = [dealList objectForKey:kDImage];
    cell.imageView.image = [UIImage imageNamed:self.stringPlaceholder];
    
    // Cell and Background Attributes
    cell.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    // TableView Separator
    [self.tableView setSeparatorColor:[UIColor redColor]];
    
    // Rounded Image
    CALayer *cellImageLayer = cell.imageView.layer;
    [cellImageLayer setCornerRadius:7];
    [cellImageLayer setMasksToBounds:YES];
    
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDeal"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dealList = [self.dealListArray objectAtIndex:indexPath.row];
        
        DealVC *dealVC = (DealVC *)segue.destinationViewController;
        
        
        dealVC.stringImage = [dealList objectForKey:kDImage];
        dealVC.stringDescription = [dealList objectForKey:kDDescription];
        dealVC.stringDiscount = [dealList objectForKey:kDiscount];

    }
}


@end
