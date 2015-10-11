//
//  MenuTVC.m
//

#import "MenuTVC.h"
#import "ItemVC.h"
#import <QuartzCore/CALayer.h>
#import <Parse/Parse.h>

NSString *const kItem = @"item";
NSString *const kPrice = @"price";
NSString *const kImage = @"image";
NSString *const kDescription = @"description";

@interface MenuTVC ()
@end

@implementation MenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    
    self.menuArray = [NSArray arrayWithObjects:self.breakfastItemsArray, self.lunchItemsArray, self.dinnerItemsArray, self.dessertItemsArray, nil];
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
    return [self.menuArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [[self.menuArray objectAtIndex:section] count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSArray *secTitlesArray = @[@"Breakfast", @"Lunch", @"Dinner", @"Dessert"];
    return [secTitlesArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *resMenu, NSError *error) {
        
        
        self.breakfastItemsArray = [resMenu objectForKey:@"breakfastMenu"];
        
        self.lunchItemsArray = [resMenu objectForKey:@"lunchMenu"];
        
        self.dinnerItemsArray = [resMenu objectForKey:@"dinnerMenu"];
        
        self.dessertItemsArray = [resMenu objectForKey:@"dessertMenu"];
        
        
    }];
//    NSDictionary *menuItems = [self.lunchItemsArray objectAtIndex:indexPath.row];
    
    // Item Name
    cell.textLabel.text = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:kItem];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:kPrice];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    // Item Image
    self.stringPlaceholder = [[[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:kImage];
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
    
    if ([segue.identifier isEqualToString:@"showItem"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *menuItems = [[self.menuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        itemVC.stringItemName = [menuItems objectForKey:kItem];
        itemVC.stringPrice = [menuItems objectForKey:kPrice];
        itemVC.stringImage = [menuItems objectForKey:kImage];
        itemVC.stringDescription = [menuItems objectForKey:kDescription];
    }
    
}

@end


