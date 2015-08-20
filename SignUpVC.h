//
//  SignUpVC.h
//

#import <UIKit/UIKit.h>

@interface SignUpVC : UIViewController <UITextFieldDelegate>

//Text Field Properties
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;


//Strings
@property (weak, nonatomic) NSString *stringUsername;
@property (weak, nonatomic) NSString *stringPassword;
@property (weak, nonatomic) NSString *stringEmail;


- (IBAction)signUpButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *oSignUpButton;

@end
