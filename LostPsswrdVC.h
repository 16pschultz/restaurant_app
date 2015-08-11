//
//  LostPsswrdVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/28/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LostPsswrdVC : UIViewController <UITextFieldDelegate> {
}

@property (strong, nonatomic) IBOutlet UILabel *outletLabel;

// String
@property (weak, nonatomic) NSString *stringEmailAddress;


// UITextField Property
@property (weak, nonatomic) IBOutlet UITextField *outletEmailTF;


- (IBAction)sendEmailButton;


@end
