//
//  MenuTVC.h
//

#import <UIKit/UIKit.h>


@interface MenuTVC : UITableViewController

@property (strong, nonatomic) NSArray *menuArray;

@property (strong, nonatomic) NSArray *breakfastItemsArray;
@property (strong, nonatomic) NSArray *lunchItemsArray;
@property (strong, nonatomic) NSArray *dinnerItemsArray;
@property (strong, nonatomic) NSArray *dessertItemsArray;

@property (strong, nonatomic) NSString *stringPlaceholder;

@end
