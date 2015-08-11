//
//  DessertMenuTVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/20/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "DessertMenuTVC.h"
#import "ItemVC.h"
#import <QuartzCore/CALayer.h>


NSString *const kItem = @"item";
NSString *const kPrice = @"price";
NSString *const kImage = @"image";
NSString *const kDescription = @"description";

@interface DessertMenuTVC ()

@end

@implementation DessertMenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *itemOne = @{kItem: @"Cookie w Ice Cream",
                              kPrice: @"3.99",
                              kImage: @"123.jpg",
                              kDescription: @"Our freshly baked cookie is accomidated with a pure vanilla ice cream topping",
                              };
    
    NSDictionary *itemTwo = @{kItem: @"CheeseCake",
                              kPrice: @"4.99",
                              kImage: @"cheeseburger.png",
                              kDescription: @"Our cheesecake will you melt in your chair",
                              };
    
    NSDictionary *itemThree = @{kItem: @"Fried Ice Cream",
                                kPrice: @"5.99",
                                kImage: @"grilled_cheese.jpg",
                                kDescription: @"Now this is what I'm talking about! If frying makes everything better, why not fry Ice Cream! Trying this delightfulness will make you happier than a monkey in banana land!",
                                };
    
    self.menuItemsArray = [NSArray arrayWithObjects:
                           
                           itemOne,
                           itemTwo,
                           itemThree,
                           
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
    
    return [self.menuItemsArray count];
    
    // Count, seen above, means it “counts” the amount of objects in the array, finds 3 (for example), and displays 3 cells
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *menuItems = [self.menuItemsArray objectAtIndex:indexPath.row];
    
    // Item Name
    cell.textLabel.text = [menuItems objectForKey:kItem];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [menuItems objectForKey:kPrice];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    // Item Image
    self.stringPlaceholder = [menuItems objectForKey:kImage];
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
    
    if ([segue.identifier isEqualToString:@"showTheItem"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *menuItems = [self.menuItemsArray objectAtIndex:indexPath.row];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        itemVC.stringItemName = [menuItems objectForKey:kItem];
        itemVC.stringPrice = [menuItems objectForKey:kPrice];
        itemVC.stringImage = [menuItems objectForKey:kImage];
        itemVC.stringDescription = [menuItems objectForKey:kDescription];
    }
    
}

@end
