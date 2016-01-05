//
//  ItemVC.h
//

#import <UIKit/UIKit.h>

@interface ItemVC : UIViewController

// Strings for assigning the Outlets
@property (strong, nonatomic) NSString *stringItemName;
@property (strong, nonatomic) NSString *stringPrice;
@property (strong, nonatomic) NSString *stringImage;
@property (strong, nonatomic) NSString *stringDescription;

// Outlets
@property (strong, nonatomic) IBOutlet UILabel *outletItemName;
@property (strong, nonatomic) IBOutlet UILabel *outletPrice;
@property (strong, nonatomic) IBOutlet UIImageView *outletImage;
@property (strong, nonatomic) IBOutlet UILabel *outletDescription;

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

@end
