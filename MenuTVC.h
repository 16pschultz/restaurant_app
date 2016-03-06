//
//  MenuTVC.h
//

#import <UIKit/UIKit.h>


@interface MenuTVC : UITableViewController

// Cell
@property (strong, nonatomic) IBOutlet UILabel *labelItem;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;



@property (strong, nonatomic) NSArray *resMenuItems;
@property (strong, nonatomic) NSMutableArray *menuArray;
@property (strong, nonatomic) NSMutableArray *secTitlesArray;
@property (strong, nonatomic) NSMutableArray *breakfastItemsArray;
@property (strong, nonatomic) NSMutableArray *lunchItemsArray;
@property (strong, nonatomic) NSMutableArray *dinnerItemsArray;
@property (strong, nonatomic) NSMutableArray *dessertItemsArray;

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

@property (strong, nonatomic) NSString *stringPlaceholder;



@property (strong, nonatomic) NSIndexPath *expandedIndexPath;



@end
