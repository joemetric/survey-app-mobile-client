//
//  NewAccountViewController.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountObserver.h"
#import "TableShrinksWhenKeyboardIsShownViewController.h"

@class ProfileViewController;
@class DatePickerViewController;
@class LabelledTableViewCell;
@class MaleFemaleTableViewCell;
@class StaticTable;

@interface NewAccountViewController : TableShrinksWhenKeyboardIsShownViewController <AccountObserver> {
	
	LabelledTableViewCell* loginCell;
	LabelledTableViewCell* passwordCell;
	LabelledTableViewCell* passwordConfirmationCell;
	LabelledTableViewCell* dobCell;
	LabelledTableViewCell* emailCell;
	LabelledTableViewCell* incomeCell;
	MaleFemaleTableViewCell* genderCell;
	
	UIActivityIndicatorView* activityIndicator;
	
	DatePickerViewController* datePicker;
	
	ProfileViewController* profileView;
	
    
	StaticTable* staticTable;
	
}

- (IBAction) signup;
- (IBAction) cancel;

@property (nonatomic, retain) ProfileViewController* profileView;


@property (nonatomic, retain)  LabelledTableViewCell* loginCell;
@property (nonatomic, retain)  LabelledTableViewCell* passwordCell;
@property (nonatomic, retain)  LabelledTableViewCell* passwordConfirmationCell;
@property (nonatomic, retain)  LabelledTableViewCell* incomeCell;
@property (nonatomic, retain)  LabelledTableViewCell* emailCell;
@property (nonatomic, retain)  LabelledTableViewCell* dobCell;
@property (nonatomic, retain)  IBOutlet MaleFemaleTableViewCell* genderCell;



@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;

@end
