//
//  DatePickerViewController.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewAccountViewController;

@interface DatePickerViewController : UIViewController <UITableViewDataSource>{
	UIDatePicker* datePicker;
	UITableView* tableView;
	UITableViewCell* cell;
	NSDateFormatter* formatter;
	NewAccountViewController* newAccountView;
}

- (IBAction) valueChanged:(UIDatePicker*)sender;
- (IBAction) done:(UIBarButtonItem*)sender;

@property (nonatomic, retain) NewAccountViewController* newAccountView;
@property (nonatomic, retain) NSDateFormatter* formatter;
@property (nonatomic, retain) UITableViewCell* cell;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

@end
