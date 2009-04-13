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
	UITextField* dateTextField;
    NSDate* initialDate;
	NSDateFormatter* formatter;
}

- (IBAction) valueChanged:(UIDatePicker*)sender;
- (IBAction) done:(UIBarButtonItem*)sender;
+(id)datePickerViewControllerWithDate:(NSDate*)date andTextField:(UITextField*)textField;

@property (nonatomic, assign) UITextField* dateTextField;
@property (nonatomic, retain) NSDateFormatter* formatter;
@property (nonatomic, retain) UITableViewCell* cell;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) NSDate* initialDate;
@end
