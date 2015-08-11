//
//  MenuTVC.m
//

#import "MenuTVC.h"
#import "ItemVC.h"
#import <QuartzCore/CALayer.h>

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
    
    NSDictionary *itemOne = @{kItem: @"Club Sandwich w fries/chips",
                              kPrice: @"6.99",
                              kImage: @"Club_San_RA.jpg",
                              kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                              };
    
    NSDictionary *itemTwo = @{kItem: @"Cheeseburger w fries/chips",
                              kPrice: @"8.99",
                              kImage: @"burger_RA.jpg",
                              kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                              };
    
    NSDictionary *itemThree = @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                                kPrice: @"5.99",
                                kImage: @"grilled_cheese_RA.jpg",
                                kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                                };
    
    NSDictionary *itemFour = @{kItem: @"Club Sandwich w fries/chips",
                              kPrice: @"6.99",
                              kImage: @"Club_San_RA.jpg",
                              kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                              };
    
    NSDictionary *itemFive = @{kItem: @"Cheeseburger w fries/chips",
                              kPrice: @"8.99",
                              kImage: @"burger_RA.jpg",
                              kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                              };
    
    NSDictionary *itemSix = @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                                kPrice: @"5.99",
                                kImage: @"grilled_cheese_RA.jpg",
                                kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                                };
    
    NSDictionary *itemSeven = @{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               };
    
    NSDictionary *itemEight = @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               };
    
    NSDictionary *itemNine = @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                              kPrice: @"5.99",
                              kImage: @"grilled_cheese_RA.jpg",
                              kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                              };
    
    NSDictionary *itemTen = @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                              kPrice: @"5.99",
                              kImage: @"grilled_cheese_RA.jpg",
                              kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                              };
    
    NSDictionary *itemEleven = @{kItem: @"Club Sandwich w fries/chips",
                                kPrice: @"6.99",
                                kImage: @"Club_San_RA.jpg",
                                kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                                };
    
    NSDictionary *itemTwelve = @{kItem: @"Cheeseburger w fries/chips",
                                kPrice: @"8.99",
                                kImage: @"burger_RA.jpg",
                                kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                                };
    
    NSDictionary *itemThirteen = @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               };
    
    self.menuItemsArray = [NSArray arrayWithObjects:
                           
                           itemOne,
                           itemTwo,
                           itemThree,
                           itemFour,
                           itemFive,
                           itemSix,
                           itemSeven,
                           itemEight,
                           itemNine,
                           itemTen,
                           itemEleven,
                           itemTwelve,
                           itemThirteen,
                           
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
    
    if ([segue.identifier isEqualToString:@"showItem"]) {
        
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


