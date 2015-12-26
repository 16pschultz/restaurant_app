//
//  MenuTVC.m
//

#import "MenuTVC.h"
#import "ItemVC.h"
#import <QuartzCore/CALayer.h>
#import <Parse/Parse.h>

@interface MenuTVC ()
@end

@implementation MenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [self queryMenuItems];
        
    self.breakfastItemsArray = [NSMutableArray new];
    self.lunchItemsArray = [NSMutableArray new];
    self.dinnerItemsArray = [NSMutableArray new];
    self.dessertItemsArray = [NSMutableArray new];
    self.secTitlesArray = [NSMutableArray new];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) queryMealTypes {
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"MenuItem"];
//    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
//    [query orderByAscending:@"menuType"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        
//        self.resMenuItems = objects;
//
//        [self.tableView reloadData];
//    }];
//
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.menuArray count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [[self.menuArray objectAtIndex:section] count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSArray *secArray = @[@"Breakfast", @"Lunch", @"Dinner", @"Dessert"];
    return [secArray objectAtIndex:section];
//    return [self.secTitlesArray objectAtIndex:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Item Name
    cell.textLabel.text = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",[[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
//    // Item Image
//    self.stringPlaceholder = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:kImage];
//    cell.imageView.image = [UIImage imageNamed:self.stringPlaceholder];
    
    // Cell and Background Attributes
    cell.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // TableView Separator
    [self.tableView setSeparatorColor:self.resColor];
    
    // Rounded Image
    CALayer *cellImageLayer = cell.imageView.layer;
    [cellImageLayer setCornerRadius:7];
    [cellImageLayer setMasksToBounds:YES];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.breakfastItemsArray objectAtIndex:indexPath.row][@"image"] == NULL) {
        
        [self performSegueWithIdentifier:@"showItem" sender:self];
    } else {
        
        [self performSegueWithIdentifier:@"showItemWPic" sender:self];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showItem"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        NSLog(@"%@", [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"]);
        itemVC.stringItemName = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
        itemVC.stringPrice = [NSString stringWithFormat:@"$%@",[[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    }
    
    if ([segue.identifier isEqualToString:@"showItemWPic"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        NSLog(@"%@", [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"]);
        itemVC.stringItemName = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
        itemVC.stringPrice = [NSString stringWithFormat:@"$%@",[[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    }
}

- (void) queryMenuItems{
    PFQuery *query = [PFQuery queryWithClassName:@"MenuItem"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query orderByAscending:@"menuType"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (PFObject *menuItem in objects) {
            
            NSNumber *switchNumber = menuItem[@"menuType"];
            int switchInt = switchNumber.intValue;
            
            switch (switchInt) {
                case 0:
                    [self.breakfastItemsArray addObject:menuItem];
                    break;
                case 1:
                    [self.lunchItemsArray addObject:menuItem];
                    break;
                case 2:
                    [self.dinnerItemsArray addObject:menuItem];
                    break;
                case 3:
                    [self.dessertItemsArray addObject:menuItem];
                    break;
                default:
                    break;
            }
        }
        
        self.menuArray = [NSMutableArray arrayWithObjects:self.breakfastItemsArray, self.lunchItemsArray, self.dinnerItemsArray, self.dessertItemsArray, nil];
        [self.tableView reloadData];
    }];
    
}


@end


