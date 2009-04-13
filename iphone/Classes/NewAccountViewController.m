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
#import "StaticTable.h"
#import "TableSection.h"
#import <Foundation/Foundation.h>


@interface NewAccountViewController ()
@property(readonly) NSDictionary* errors;
@property(nonatomic, retain) StaticTable* staticTable;
@end

@implementation NewAccountViewController
@synthesize username, password, passwordConfirmation, emailAddress, gender, dob, income;
@synthesize activityIndicator, profileView, tableView, datePicker;;
@synthesize keyboardIsShowing;
@synthesize loginCell, passwordCell, passwordConfirmationCell, emailCell, incomeCell, dobCell, genderCell;
@synthesize staticTable;

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

-(void)initialiseCells{
	loginCell.errorField = @"login";
	passwordCell.errorField = @"password";
    passwordConfirmationCell.errorField = @"password_confirmation";
    emailCell.errorField = @"email";
    incomeCell.errorField = @"income";
    dobCell.errorField = @"birthdate";
	
}

-(void)populateBasicSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Basics"];
	[staticTable addSection:section];
	
	[section addCell:loginCell];
	[section addCell:passwordCell];
	[section addCell:passwordConfirmationCell];
	[section addCell:emailCell];
}

-(void)populateDemographicsSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Demographics"];
	[staticTable addSection:section];
	
	[section addCell:incomeCell];
	[section addCell:dobCell];
	[section addCell:genderCell];
}


-(void)viewDidLoad{
	[self initialiseCells];
	self.staticTable = [StaticTable staticTableForTableView:tableView];
	[self populateBasicSection];
	[self populateDemographicsSection];
    self.tableView.backgroundColor = [UIColor clearColor];
	[[Account currentAccount] onChangeNotifyObserver:self];
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
    NSLog(@"textFieldDidBeginEditing");
	if( textField == username ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == password ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == passwordConfirmation ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == emailAddress ) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
	} else if( textField == income ) {
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
	self.staticTable = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark TableViewDelegate and DataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
	return [staticTable numberOfSectionsInTableView:tv];
}

- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)section{
    return [staticTable tableView:tv viewForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tv heightForHeaderInSection:(NSInteger)section{
    return [staticTable tableView:tv heightForHeaderInSection:section];
}

-(UIView*) tableView:(UITableView*) tv viewForFooterInSection:(NSInteger)section{
    return [staticTable tableView:tv viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tv heightForFooterInSection:(NSInteger)section{
	return [staticTable tableView:tv heightForFooterInSection:section];
}


- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [staticTable tableView:nil numberOfRowsInSection:section];
}



- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [staticTable tableView:tv cellForRowAtIndexPath:indexPath];
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
	NSLog(@"didSelectRowAtIndexPath: row: %d section: %d", indexPath.row, indexPath.section);
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
            static const int Dec_15_1970 = 61606800;
			self.datePicker = [DatePickerViewController datePickerViewControllerWithDate:[NSDate dateWithTimeIntervalSince1970:Dec_15_1970]];
		}
		[self presentModalViewController:datePicker	animated:YES];
	}
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

-(void) changeInAccount:(Account*)account{	
	[staticTable handleErrors:[[Account currentAccount] errors]];
	[activityIndicator stopAnimating];
	[tableView reloadData];
}

-(NSDictionary*)errors{
	return [Account currentAccount].errors;
}


@end
