//
//  PercentageToDonateController .m
//  Survey
//
//  Created by mobile06 on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PercentageToDonateController.h"


@implementation PercentageToDonateController

@synthesize percentageToDonatePicker,percentageToDonate,percentage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)];
		self.navigationItem.leftBarButtonItem = doneButton;
		[doneButton release];
	}
	self.navigationItem.title = @"SETTINGS";		
	
    return self;
}

- (void)doneButtonClicked 
{	
	percentage = [[NSString stringWithFormat:@"%d%%", selectedRow * 10] retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"selectedPercentageToDonate" object:percentage];	
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(broadcastDonationpercentage:) name:@"broadcastDonationpercentage" object:nil];
	
	//percentageToDonatePicker.transform = CGAffineTransformMakeScale(0.3f, 0.9f);
	percentageToDonatePicker.frame = CGRectMake(120, 100, 100, 220);
}

#pragma mark -
#pragma mark Sending Notification

- (void) broadcastDonationpercentage:(NSNotification*) notification
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"selectedPercentageToDonate" object:percentage];	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.percentage = nil;
	self.percentageToDonate = nil;
	self.percentageToDonatePicker = nil;
}

- (void)dealloc 
{
	[percentage release];

	[percentageToDonate release];
	[percentageToDonatePicker release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark TableViews Methods

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (UILabel *)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 280.0, 44.0)] autorelease];
	}
	
	switch(row)
	{
		case 0:			
			retval.text = @"0%";
			break;
		case 1:
			retval.text = @"10%";
			break;
		case 2:
			retval.text = @"20%";
			break;
		case 3:
			retval.text = @"30%";
			break;
		case 4:
			retval.text = @"40%";
			break;
		case 5:
			retval.text = @"50%";
			break;
		case 6:
			retval.text = @"60%";
			break;
		case 7:
			retval.text = @"70%";
			break;
		case 8:
			retval.text = @"80%";
			break;
		case 9:
			retval.text = @"90%";
			break;
		case 10:
			retval.text = @"100%";
			break;
		default:
			break;		
	}
	
	retval.font = [UIFont boldSystemFontOfSize:20];
	retval.backgroundColor = [UIColor clearColor];
	retval.textAlignment = UITextAlignmentCenter;
	
	return retval;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 11;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)pickerView:(UIPickerView *) thePickerView didSelectRow:(NSInteger) row
	   inComponent:(NSInteger) component
{
	selectedRow = row;
}

@end