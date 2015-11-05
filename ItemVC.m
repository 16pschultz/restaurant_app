//
//  ItemVC.m
//

#import "ItemVC.h"
#import "MenuTVC.h"

@interface ItemVC ()

@end

@implementation ItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.outletItemName.text = self.stringItemName;
    self.outletPrice.text = [NSString stringWithFormat:@"$%@",self.stringPrice];
    
    
    self.outletImage.image = [UIImage imageNamed:self.stringImage];
    self.outletDescription.text = self.stringDescription;
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    self.outletDescription = [[UILabel alloc] initWithFrame:CGRectMake(16, 325, 288, 202)];
    self.outletDescription.numberOfLines = 0; // This will wrap text in new line
    [self.outletDescription sizeToFit];
    [self.view addSubview:self.outletDescription];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
