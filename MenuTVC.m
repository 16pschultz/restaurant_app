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
    
    self.breakfastItemsArray = @[@{kItem: @"Southern Pancakes w butter",
                                   kPrice: @"5.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"Oooh dawgy! Our Southern style pancakes tastes like the ones your mama made back home!",
                                  },
                                 @{kItem: @"Egg Sandwich w bacon",
                                   kPrice: @"4.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"Egg-celence in a Sandwich! Toppings include: Bacon, sausage, peppers, and fried onions",
                                   },
                                 @{kItem: @"Scrambled Eggs w bacon",
                                   kPrice: @"4.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"This is egg-zactly what your stomach needs to wake up to!",
                                   },
                                 @{kItem: @"Waffles w butter",
                                   kPrice: @"5.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"Our waffles are crispy on the outside and soft on the inside, oh yeah I said it!",
                                   },
                                ];
    
    self.lunchItemsArray = @[@{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               },
                             @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               },
                             @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               },
                             @{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               },
                             @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               },
                             @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               },
                             ];
    
    self.dinnerItemsArray = @[@{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               },
                             @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               },
                             @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               },
                             @{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               },
                             @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               },
                             @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               },
                             @{kItem: @"Club Sandwich w fries/chips",
                               kPrice: @"6.99",
                               kImage: @"Club_San_RA.jpg",
                               kDescription: @"Our flavorful Club Sandwich offers a variety of tastes combined into one gorgeous looking and great tasting sandwich!",
                               },
                             @{kItem: @"Cheeseburger w fries/chips",
                               kPrice: @"8.99",
                               kImage: @"burger_RA.jpg",
                               kDescription: @"Our juicy burgers our cooked to perfection leaving you wanting more. Each of our burgers made with Kobe Beef topped with your choice of cheese: American, Cheddar, Swiss, and Provalone",
                               },
                             @{kItem: @"Grilled Cheese Sandwich w fries/chips",
                               kPrice: @"5.99",
                               kImage: @"grilled_cheese_RA.jpg",
                               kDescription: @"Now this is cheesy! All of our Grilled Cheese Sandwich's are cooked to a golden crisp that will just give you the right crunch!Toppings? The choice is yours! With up to three toppings per sandwich. Toppings include: Bacon, Chicken, Beef, Pepperoni, Tomatoes, Ham, and Steak. Addition toppings: $1.49 each",
                               },
                             ];
    
    self.dessertItemsArray = @[@{kItem: @"Cheesecake",
                                   kPrice: @"4.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"I'll have you know that our cheesecake will turn you into one",
                                   },
                                 @{kItem: @"Ice Cream Sundae",
                                   kPrice: @"5.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"Even if it aint Sunday, you gotta have our Sundae!",
                                   },
                                 @{kItem: @"Ice Cream & Chocolate",
                                   kPrice: @"3.99",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"Baseball scoop-ice cream? And chocolate on the side? It's already ordered!",
                                   },
                                 @{kItem: @"Deep Fried French Fries",
                                   kPrice: @"4.50",
                                   kImage: @"Club_San_RA.jpg",
                                   kDescription: @"You like French Fries? Oh yeah..we know. That's why we deep fried em!",
                                   },
                                 ];
    
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


