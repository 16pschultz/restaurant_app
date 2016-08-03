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
    
    self.completeMenuArray = [[NSMutableArray alloc]init];
    
    NSLog(@"%@", self.mealTypesArray);
//    [self queryMealType];
    [self queryMenuItems];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    NSLog(@"%@", self.mealTypesArray);
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = self.offSetColor;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.mealTypesArray count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
//    return [[self.mealTypesArray objectAtIndex:section] objectForKey:@"meal"];
    return @"Peach";

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [[self.completeMenuArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Item Name
    cell.textLabel.text = [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",[[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
//    // Item Image
//    self.stringPlaceholder = [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:kImage];
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

    [tableView beginUpdates];
    
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        
        self.expandedIndexPath = nil;
    } else {
        
        self.expandedIndexPath = indexPath;
    }
    
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        return 140.0;
    }
    return 70.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showItem"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        NSLog(@"%@", [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"]);
        itemVC.stringItemName = [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
        itemVC.stringPrice = [NSString stringWithFormat:@"$%@",[[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    }
    
    if ([segue.identifier isEqualToString:@"showItemWPic"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ItemVC *itemVC = (ItemVC *)segue.destinationViewController;
        
        NSLog(@"%@", [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"]);
        itemVC.stringItemName = [[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item"];
        itemVC.stringPrice = [NSString stringWithFormat:@"$%@",[[[self.completeMenuArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    }
}

//- (void) queryMealType {
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"MealType"];
//    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
//    [query orderByAscending:@"createdAt"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        self.mealTypesArray = objects;
//        NSLog(@"%@", self.mealTypesArray);
//        
//    }];
//
//}


- (void) queryMenuItems{
    
    PFQuery *query = [PFQuery queryWithClassName:@"MenuItem"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"%@", objects);
        
        for (int i = 0; i < [self.mealTypesArray count]; i++) {
            
            for (int j = 0; j < [objects count]; j++) {
                
                if ([[objects objectAtIndex:j] objectForKey:@"mealTypeId"] == [[self.mealTypesArray objectAtIndex:i] objectForKey:@"objectId"]) {
                    
                    [[self.completeMenuArray objectAtIndex:i] addObject:objects[i][j]];

                }
            }
        }
        
        [self.tableView reloadData];
    }];
    
}


@end


