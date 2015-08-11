//
//  LoginVC.h
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController <UITextFieldDelegate>

//Text Field Properties
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

//Strings
@property (weak, nonatomic) NSString *stringUsername;
@property (weak, nonatomic) NSString *stringPassword;


- (IBAction)loginButton:(id)sender;

- (IBAction)signUpLaterButton:(id)sender;


@end
