
//
//  LoginVC.m
//

#import "LoginVC.h"
#import <Parse/Parse.h>

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.oLogInButton layer] setBorderWidth:1.0f];
    [[self.oLogInButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    self.usernameField.frame = CGRectMake (32, 172, 257, 50);
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Preparing the text fields to dismiss when user hits 'Return'
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    /*
     // If the app if linked with Navigation
     self.navigationItem.hidesBackButton = YES;
     */
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)loginButton:(id)sender {
    
    self.stringUsername = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.stringPassword = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.stringUsername length] == 0 || [self.stringPassword length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a valid username and password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
        
    } else {
        
        [PFUser logInWithUsernameInBackground:self.stringUsername password:self.stringPassword
                                        block:^(PFUser *user, NSError *error) {
                                            
                                            if (user) {
                                                
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                                
                                            } else {
                                                
                                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                
                                                [alertView show];
                                            }
                                            
                                        }];
        
    }
    
    
}

- (IBAction)signUpLaterButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];        
    }
}

#pragma UITextField Dismissing Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}










@end
