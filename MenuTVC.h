//
//  MenuTVC.h
//

#import <UIKit/UIKit.h>


@interface MenuTVC : UITableViewController

@property (strong, nonatomic) NSMutableArray *menuArray;

@property (strong, nonatomic) NSMutableArray *breakfastItemsArray;
@property (strong, nonatomic) NSMutableArray *lunchItemsArray;
@property (strong, nonatomic) NSMutableArray *dinnerItemsArray;
@property (strong, nonatomic) NSMutableArray *dessertItemsArray;

@property (strong, nonatomic) NSString *stringPlaceholder;

@property (strong, nonatomic) NSString *currentRestaurantId;

@end
