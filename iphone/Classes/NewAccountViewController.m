//
//  NewAccountViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "SegmentedTableViewCell.h"
#import "DatePickerViewController.h"
#import "Account.h"
#import "RestConfiguration.h"


@interface NewAccountViewController (Private)
- (LabelledTableViewCell*) loadLabelledCellWthText:(NSString*)labelText;
- (SegmentedTableViewCell*) loadSegmentedCell;
- (NSDictionary*) collectParams;
- (void) highlightCell:(LabelledTableViewCell*)cell withErrorForField:(NSString*)field;
- (NSArray*) validErrorKeysForSection:(NSInteger) section;
@property(readonly) NSDictionary* errors;
@end

@implementation NewAccountViewController
@synthesize username, password, passwordConfirmation, emailAddress, gender, dob, income;
@synthesize activityIndicator, profileView, tableView, datePicker;;
@synthesize keyboardIsShowing;
@synthesize loginCell, passwordCell, passwordConfirmationCell, emailCell, incomeCell, dobCell, genderCell;

- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self
										  selector:@selector(keyboardWillShow:)
										  name:UIKeyboardWillShowNotification
										  object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										  selector:@selector(keyboardWillHide:)
										  name:UIKeyboardWillHideNotification
										  object:nil];	
	[super viewWillAppear:animated];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    if (self.keyboardIsShowing == NO)
    {
        self.keyboardIsShowing = YES;
        CGRect frame = self.tableView.frame;
        frame.size.height -= keyboardHeight;
		
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        self.tableView.frame = frame;
        [UIView commitAnimations];
    }
}

-(void) keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    if (self.keyboardIsShowing == YES)
    {
        self.keyboardIsShowing = NO;
        CGRect frame = self.tableView.frame;
        frame.size.height += keyboardHeight;
		
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        self.tableView.frame = frame;
        [UIView commitAnimations];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
	if( textField == username ) {
		[password becomeFirstResponder];
		[username resignFirstResponder];
	} else if( textField == password ) {
		[passwordConfirmation becomeFirstResponder];
		[password resignFirstResponder];
	} else if( textField == passwordConfirmation ) {
		[emailAddress becomeFirstResponder];
		[passwordConfirmation resignFirstResponder];
	} else if( textField == emailAddress ) {
		[emailAddress resignFirstResponder];
		[income becomeFirstResponder];
		[income becomeFirstResponder];
	} else if( textField == income ) {
		[textField resignFirstResponder];
	}
	

	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	if( textField == username ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == password ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == passwordConfirmation ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == emailAddress ) {
		NSLog(@"email");
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == income ) {
		NSLog(@"income");
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	}
}

- (void)dealloc {
	[loginCell release];
	[passwordCell release];
	[passwordConfirmationCell release];
	[emailCell release];
	[incomeCell release];
	[dobCell release];
	[genderCell release];
	[tableView release];
	[username release];
	[password release];
	[passwordConfirmation release];
	[emailAddress release];
	[gender release];
	[dob release];
	[income release];
	[activityIndicator release];
	[profileView release];
	[datePicker release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableViewDelegate and DataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
	return 2;
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return section == 0 ? @"Basics" : @"Demographics";
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	NSArray* sectionKeys = [self validErrorKeysForSection:section];
	NSMutableString* result = [NSMutableString stringWithCapacity:64];
	for( NSString* key in self.errors ) {
		if( [sectionKeys containsObject:key] ) {
			NSArray* messages = (NSArray*)[self.errors objectForKey:key];
			for( NSString* message in messages ) {
				[result appendFormat:@"%@ %@\n", key, message];
			}
		}
	}
	return result;
}

- (NSArray*) validErrorKeysForSection:(NSInteger) section {
	if( section == 0 ){ return [NSArray arrayWithObjects:@"login", @"password", @"password_confirmation", @"email", nil]; }
	else if( section == 1 ) { return [NSArray arrayWithObjects:@"income", @"birthdate", @"gender", nil];}
	return [NSArray array];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? 4 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"tableView:%@ cellForRowAtIndexPath:%d %d", tv, indexPath.section, indexPath.row);
	if( indexPath.section == 0 )
	{
		if( indexPath.row == 0 ) {
			[self highlightCell:loginCell withErrorForField:@"login"];
			return loginCell;
		}
		else if( indexPath.row == 1) {
			[self highlightCell:passwordCell withErrorForField:@"password"];
			return passwordCell;
		}
		else if( indexPath.row == 2) {
			[self highlightCell:passwordConfirmationCell withErrorForField:@"password_confirmation"];
			return passwordConfirmationCell;
		}
		else {
			[self highlightCell:emailCell withErrorForField:@"email"];
			return emailCell;
		}
	} else {
		if( indexPath.row == 0 ) {
			[self highlightCell:incomeCell withErrorForField:@"income"];
			return incomeCell;
		}
		else if( indexPath.row == 1) {
			[self highlightCell:dobCell withErrorForField:@"birthdate"];
			return dobCell;
		}
		else {
			[self highlightCell:genderCell withErrorForField:@"gender"];
			return genderCell;
		}
		
	}
	return nil;
}

- (void) highlightCell:(LabelledTableViewCell*)cell withErrorForField:(NSString*)field {
	NSArray* fieldErrors = (NSArray*)[self.errors objectForKey:field];
	if( fieldErrors != nil || fieldErrors.count > 0 ) {
		cell.label.textColor = [UIColor redColor];
	} else {
		cell.label.textColor = [UIColor blackColor];
	}
}

-(NSDateFormatter*)dateFormatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	return dateFormatter;
	
}

- (void) dismissModalViewControllerAnimated:(BOOL) animated {
	self.dob.text = [[self dateFormatter] stringFromDate:self.datePicker.datePicker.date];
	[super dismissModalViewControllerAnimated:animated];
}

- (void) tableView:(UITableView*)tv didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	NSLog(@"didSelectRowAtIndexPath");
	if( indexPath.section == 0 && indexPath.row == 0 ) {
		[username becomeFirstResponder];
	} else if( indexPath.section == 0 && indexPath.row == 1 ) {
		[password becomeFirstResponder];
	} else if( indexPath.section == 0 && indexPath.row == 2 ) {
		[passwordConfirmation becomeFirstResponder];
	} else if( indexPath.section == 0 && indexPath.row == 3 ) {
		[emailAddress becomeFirstResponder];
	} else if( indexPath.section == 1 && indexPath.row == 0 ) {
		[income becomeFirstResponder];
	} else if( indexPath.section == 1 && indexPath.row == 1 ) {
		if( self.datePicker == nil ) {
			self.datePicker = [[[DatePickerViewController alloc] initWithNibName:@"DatePickerView" bundle:nil] autorelease];
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterMediumStyle];
			self.datePicker.datePicker.date = [formatter dateFromString:@"Dec 15, 1971"];
			[formatter release];
			self.datePicker.newAccountView = self;
		}
		[self presentModalViewController:datePicker	animated:YES];
	}
}

- (LabelledTableViewCell*) loadLabelledCellWthText:(NSString*)labelText {
	NSLog(@"loadLabelledCellWthText: %@", labelText);
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LabelledTableViewCell" owner:self options:nil];
	LabelledTableViewCell* cell = (LabelledTableViewCell*)[nib objectAtIndex:0];
	cell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	cell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
	cell.tableView = self.tableView;
	cell.label.text = labelText;
	return cell;
}

- (SegmentedTableViewCell*) loadSegmentedCell {
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"SegmentedTableViewCell" owner:self options:nil];
	SegmentedTableViewCell* cell = (SegmentedTableViewCell*)[nib objectAtIndex:0];
	cell.tableView = self.tableView;
	return cell;
}



#pragma mark -
#pragma mark Button actions

- (IBAction) signup {
	Account* account = [Account currentAccount];
	account.username = loginCell.textField.text ;
	account.password = passwordCell.textField.text;
	account.email = emailCell.textField.text;
	account.passwordConfirmation = passwordConfirmationCell.textField.text;
	account.gender = genderCell.segControl.selectedSegmentIndex == 0? @"M" : @"F";
	account.income = [incomeCell.textField.text integerValue];
	account.birthdate = [[self dateFormatter] dateFromString:dobCell.textField.text];
	[account createNew];
	[activityIndicator startAnimating];
}


- (IBAction) cancel {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(void) accountChanged{	
	[activityIndicator stopAnimating];
	[tableView reloadData];
}

-(NSDictionary*)errors{
	return [Account currentAccount].errors;
}


@end
