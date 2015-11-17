//
//  MenuTVC.h
//

#import <UIKit/UIKit.h>


@interface MenuTVC : UITableViewController

@property (strong, nonatomic) NSArray *resMenuItems;
@property (strong, nonatomic) NSMutableArray *menuArray;
@property (strong, nonatomic) NSMutableArray *secTitlesArray;
@property (strong, nonatomic) NSMutableArray *breakfastItemsArray;
@property (strong, nonatomic) NSMutableArray *lunchItemsArray;
@property (strong, nonatomic) NSMutableArray *dinnerItemsArray;
@property (strong, nonatomic) NSMutableArray *dessertItemsArray;

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColorOne;
@property (strong, nonatomic) UIColor  *resColorTwo;

@property (strong, nonatomic) NSString *stringPlaceholder;


@end
