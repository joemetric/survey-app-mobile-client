//
//  DatePickerViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "DatePickerViewController.h"
#import "NewAccountViewController.h"
#import "NSObject+CleanUpProperties.h"

@implementation DatePickerViewController
@synthesize datePicker, tableView, cell, formatter, initialDate;
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

- (IBAction) valueChanged:(UIDatePicker*)sender {
	self.cell.text = [self.formatter stringFromDate:sender.date];
}

- (IBAction) done:(UIBarButtonItem*)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

+(id)datePickerViewControllerWithDate:(NSDate*)date{
    DatePickerViewController* result = [[[self alloc] initWithNibName:@"DatePickerView" bundle:nil] autorelease];
    result.initialDate = date;
    return result;
}

-(void)viewDidLoad{
    datePicker.date = initialDate;
}

#pragma mark -
#pragma mark TableViewDelegate and DataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
	return 1;
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return @"\n\n\n";
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	return @"";
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if( self.cell == nil ) {
		self.cell = [[[UITableViewCell alloc] init] autorelease];
		self.cell.accessoryType = UITableViewCellAccessoryNone;
		self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
		self.formatter = [[[NSDateFormatter alloc] init] autorelease];
		[self.formatter setDateStyle:NSDateFormatterLongStyle];
	}
	self.cell.text = [self.formatter stringFromDate:datePicker.date];
	return self.cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



- (void)dealloc {
    [self setEveryObjCObjectPropertyToNil];
    [super dealloc];
}


@end
