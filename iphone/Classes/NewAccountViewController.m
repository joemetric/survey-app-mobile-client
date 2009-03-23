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
@end

@implementation NewAccountViewController
@synthesize username, password, emailAddress, gender, dob, income;
@synthesize activityIndicator, profileView, tableView, datePicker;;
@synthesize keyboardIsShowing;

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
	[textField resignFirstResponder];
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	[self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)dealloc {
	[tableView release];
	[username release];
	[password release];
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

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return section = 0 ? 3 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if( indexPath.section == 0 )
	{
		if( indexPath.row == 0 ) {
			LabelledTableViewCell* cell = [self loadLabelledCellWthText:@"Username"];
			self.username = cell.textField;	
			cell.textField.delegate = self;
			return cell;
		}
		else if( indexPath.row == 1) {
			LabelledTableViewCell* cell = [self loadLabelledCellWthText:@"Password"];
			cell.textField.secureTextEntry = YES;
			self.password = cell.textField;
			cell.textField.delegate = self;
			return cell;
		}
		else {
			LabelledTableViewCell* cell = [self loadLabelledCellWthText:@"Email"];
			cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
			self.emailAddress = cell.textField;
			cell.textField.delegate = self;
			return cell;
		}
	} else {
		if( indexPath.row == 0 ) {
			LabelledTableViewCell* cell = [self loadLabelledCellWthText:@"Date of Birth"];
			cell.textField.placeholder = @"Dec 12, 1971";
			cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
			cell.textField.enabled = NO;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			self.dob = cell.textField;
			return cell;
		}
		else if( indexPath.row == 1) {
			LabelledTableViewCell* cell = [self loadLabelledCellWthText:@"Income"];
			cell.textField.placeholder = @"99999";
			cell.textField.delegate = self;
			cell.textField.keyboardType = UIKeyboardTypeNumberPad;
			self.income = cell.textField;
			return cell;
		}
		else {
			SegmentedTableViewCell* cell = [self loadSegmentedCell];
			cell.label.text = @"Gender";	
			self.gender = cell.segControl;
			return cell;
		}
		
	}
	return nil;
}

- (void) dismissModalViewControllerAnimated:(BOOL) animated {
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	self.dob.text = [formatter stringFromDate:self.datePicker.datePicker.date];
	[formatter release];
	[super dismissModalViewControllerAnimated:animated];
}

- (void) tableView:(UITableView*)tv didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	NSLog(@"CELL SELECT!");
	// date of birth
	if( indexPath.section == 1 && indexPath.row == 0 ) {
		if( self.datePicker == nil ) {
			self.datePicker = [[[DatePickerViewController alloc] initWithNibName:@"DatePickerView" bundle:nil] autorelease];
			self.datePicker.newAccountView = self;
		}
		[self presentModalViewController:datePicker	animated:YES];
	}
}

- (LabelledTableViewCell*) loadLabelledCellWthText:(NSString*)labelText {
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
    [self.activityIndicator startAnimating];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username.text forKey:@"login"];
    [params setObject:emailAddress.text forKey:@"email"];
    [params setObject:password.text forKey:@"password"];
    [params setObject:password.text forKey:@"password_confirmation"];
    [params setObject:income.text forKey:@"income"];
    [params setObject:dob.text forKey:@"birthdate"];
    [params setObject:(gender.selectedSegmentIndex == 0 ? @"M" : @"F") forKey:@"gender"];
    Account *account = [Account createWithParams:params];
    [self.activityIndicator stopAnimating];
    if (account) {
        [RestConfiguration setPassword:password.text];
        [RestConfiguration setUsername:username.text];
        
        /** Hack - create account from currentAccount resource **/
        [[Account currentAccount] loadCurrent];
        
        [self.profileView dismissModalViewControllerAnimated:YES];
    } else {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Account Creation Failed" message:@"We were unable to create an account with those details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert show];
    }
    [params release];
}

- (IBAction) cancel {
	[self.profileView dismissModalViewControllerAnimated:YES];
}


@end
