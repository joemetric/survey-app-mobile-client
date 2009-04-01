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
@class LabelledTableViewCell;
@class SegmentedTableViewCell;

@interface NewAccountViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	UITextField* username;
	UITextField* password;
	UITextField* passwordConfirmation;
	UITextField* emailAddress;
	UITextField* income;
	UITextField* dob;
	UISegmentedControl* gender;
	
	LabelledTableViewCell* loginCell;
	LabelledTableViewCell* passwordCell;
	LabelledTableViewCell* passwordConfirmationCell;
	LabelledTableViewCell* emailCell;
	LabelledTableViewCell* incomeCell;
	LabelledTableViewCell* dobCell;
	SegmentedTableViewCell* genderCell;
	
	UIActivityIndicatorView* activityIndicator;
	UITableView* tableView;
	
	DatePickerViewController* datePicker;
	
	ProfileViewController* profileView;
	
	BOOL keyboardIsShowing;
	
	NSDictionary* errors;
}

- (IBAction) signup;
- (IBAction) cancel;

@property (nonatomic, retain) ProfileViewController* profileView;

@property (nonatomic, retain) IBOutlet UITextField* username;
@property (nonatomic, retain) IBOutlet UITextField* password;
@property (nonatomic, retain) IBOutlet UITextField* passwordConfirmation;
@property (nonatomic, retain) IBOutlet UITextField* income;
@property (nonatomic, retain) IBOutlet UISegmentedControl* gender;
@property (nonatomic, retain) IBOutlet UITextField* dob;
@property (nonatomic, retain) IBOutlet UITextField* emailAddress;


@property (nonatomic, retain) IBOutlet LabelledTableViewCell* loginCell;
@property (nonatomic, retain) IBOutlet LabelledTableViewCell* passwordCell;
@property (nonatomic, retain) IBOutlet LabelledTableViewCell* passwordConfirmationCell;
@property (nonatomic, retain) IBOutlet LabelledTableViewCell* emailCell;
@property (nonatomic, retain) IBOutlet LabelledTableViewCell* incomeCell;
@property (nonatomic, retain) IBOutlet LabelledTableViewCell* dobCell;
@property (nonatomic, retain) IBOutlet SegmentedTableViewCell* genderCell;



@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

@property (nonatomic, retain) IBOutlet DatePickerViewController* datePicker;

@property (nonatomic) BOOL keyboardIsShowing;

@property (nonatomic, retain) NSDictionary* errors;
@end
