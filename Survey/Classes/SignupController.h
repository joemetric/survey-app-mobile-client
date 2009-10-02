//
//  SignupController.h
//  Survey
//
//  Created by Allerin on 09-10-2.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginController;

@interface SignupController : UIViewController {
	UITableView *signupTable;
	UITableViewCell *loginCell;
	UITableViewCell *nameCell;
	UITableViewCell *emailCell;
	UITableViewCell *passwordCell;
	UITableViewCell *passwordConfirmationCell;
	UITextField *loginField;
	UITextField *nameField;
	UITextField *emailField;
	UITextField *passwordField;
	UITextField *passwordConfirmationField;
	
	LoginController *loginController;
}

@property (nonatomic, retain) IBOutlet UITableView *signupTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *loginCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *nameCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *emailCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *passwordCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *passwordConfirmationCell;
@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextField *passwordConfirmationField;
@property (nonatomic, retain) IBOutlet LoginController *loginController;

- (IBAction)cancel;
- (IBAction)done;

@end
