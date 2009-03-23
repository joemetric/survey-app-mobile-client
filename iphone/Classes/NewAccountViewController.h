//
//  NewAccountViewController.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileViewController;
@class DatePickerViewController;

@interface NewAccountViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	UITextField* username;
	UITextField* password;
	UITextField* passwordConfirmation;
	UITextField* emailAddress;
	UITextField* income;
	UITextField* dob;
	UISegmentedControl* gender;
	
	UIActivityIndicatorView* activityIndicator;
	UITableView* tableView;
	
	DatePickerViewController* datePicker;
	
	ProfileViewController* profileView;
	
	BOOL keyboardIsShowing;
}

- (IBAction) signup;
- (IBAction) cancel;

@property (nonatomic, retain) ProfileViewController* profileView;

@property (nonatomic, retain) UITextField* username;
@property (nonatomic, retain) UITextField* password;
@property (nonatomic, retain) UITextField* passwordConfirmation;
@property (nonatomic, retain) UITextField* income;
@property (nonatomic, retain) UISegmentedControl* gender;
@property (nonatomic, retain) UITextField* dob;
@property (nonatomic, retain) UITextField* emailAddress;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

@property (nonatomic, retain) IBOutlet DatePickerViewController* datePicker;

@property (nonatomic) BOOL keyboardIsShowing;
@end
