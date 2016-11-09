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
    
    
    self.completeMenuArray = [[NSMutableArray alloc] init];
    
    [self queryMealType];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
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
    return [self.completeMenuArray count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.completeMenuArray objectAtIndex:section] objectForKey:@"kMealType"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [[[self.completeMenuArray objectAtIndex:section] objectForKey:@"kMenu"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Item Name
    cell.textLabel.text = [[[[self.completeMenuArray objectAtIndex:indexPath.section] objectForKey:@"kMenu"] objectAtIndex:indexPath.row] objectForKey:@"item"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    
    // Item Price
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",[[[[self.completeMenuArray objectAtIndex:indexPath.section] objectForKey:@"kMenu"] objectAtIndex:indexPath.row] objectForKey:@"price"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Noteworthy" size:12];
    cell.detailTextLabel.textColor = [UIColor blackColor];

    
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

- (void) queryMealType {
    
    PFQuery *query = [PFQuery queryWithClassName:@"MealType"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSLog(@"%@", objects);
        
        [self queryMenuItems:objects];
    }];
}


- (void) queryMenuItems:(NSArray *)mealTypes {
    
    PFQuery *query = [PFQuery queryWithClassName:@"MenuItem"];
    [query whereKey:@"restaurantId" equalTo:self.resObjectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
//    NSMutableArray *tempMArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [mealTypes count]; i++) {
            
            NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
            [myDictionary setObject: [[mealTypes objectAtIndex:i] objectForKey:@"meal"] forKey:@"kMealType"];
            
            NSString *objID = [[mealTypes objectAtIndex:i] objectId];
            NSLog(@"%@", objID);
            
            NSMutableArray *tempMArr = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < [objects count]; j++) {
                
                NSString *mealID = [[objects objectAtIndex:j] objectForKey:@"mealTypeId"];

                if ([objID isEqualToString:mealID]) {
                    
                    [tempMArr addObject:[objects objectAtIndex:j]];
                    NSLog(@"%@", tempMArr);
                }
            }
            
            [myDictionary setObject: tempMArr forKey:@"kMenu"];
            [self.completeMenuArray addObject:myDictionary];
        }
        for (NSObject *myObject in self.completeMenuArray) {
            NSLog(@"\n\n\n\n ############### %@\n\n\n\n\n", myObject);
        }
        [self.tableView reloadData];
    }];
    

    
    [self.tableView reloadData];
}


@end


