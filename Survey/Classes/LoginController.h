//
//  LoginViewController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SignupController;

@interface LoginController : UIViewController {
	UITableView *loginTable;
	UITableViewCell *usernameCell;
	UITableViewCell *passwordCell;
	UITextField *usernameField;
	UITextField *passwordField;
	
	SignupController *signupController;	
	BOOL isSignUp;
}

@property (nonatomic, retain) IBOutlet UITableView *loginTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *usernameCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *passwordCell;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) SignupController *signupController;
@property (nonatomic, assign) BOOL isSignUp;


- (IBAction)login;
- (IBAction)signup;

@end
