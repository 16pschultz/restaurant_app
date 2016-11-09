//
//  MenuTVC.h
//

#import <UIKit/UIKit.h>


@interface MenuTVC : UITableViewController

@property (strong, nonatomic) NSMutableArray *completeMenuArray;

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

@property (strong, nonatomic) NSString *stringPlaceholder;

@property (strong, nonatomic) NSIndexPath *expandedIndexPath;



@end
