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
#import "NSObject+CleanUpProperties.h"

@interface NewAccountViewController ()
@property(readonly) NSDictionary* errors;
@property(nonatomic, retain) StaticTable* staticTable;
@end

@implementation NewAccountViewController
@synthesize  gender, dob;
@synthesize activityIndicator, profileView, tableView, datePicker;;
@synthesize keyboardIsShowing;
@synthesize  dobCell, genderCell, loginCell, emailCell, passwordCell, passwordConfirmationCell, incomeCell;
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



-(void)populateBasicSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Basics"];
	[staticTable addSection:section];
	
	self.loginCell = [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"login"] 
		withLabelText:@"Login"] 
		withPlaceholder:@"joe"] 
		withoutCorrections];
	self.passwordCell= [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"password"] 
		withLabelText:@"Password"] 
		withPlaceholder:@"min 6 chars"] 
		makeSecure];
	self.passwordConfirmationCell= [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"password_confirmation"]
		withLabelText:@"Confirm P/W"] 
		withPlaceholder:@"confirm password"] 
		makeSecure];
	self.emailCell = [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"email"] 
		withLabelText:@"Email"] 
		withPlaceholder:@"joe@example.com"] 
		makeEmail];
    [section addCell:loginCell];
    [section addCell:passwordCell];
    [section addCell:passwordConfirmationCell];
    [section addCell:emailCell];
}

-(void)populateDemographicsSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Demographics"];
	[staticTable addSection:section];
	
	self.incomeCell = [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"income"] 
		withLabelText:@"Income"] 
		withPlaceholder:@"999999"] 
		withKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [section addCell:self.incomeCell];
	[section addCell:dobCell];
	[section addCell:genderCell];
}


-(void)viewDidLoad{
	self.staticTable = [StaticTable staticTableForTableView:tableView];
    [dobCell withErrorField:@"birthdate"];
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



- (void)dealloc {
    [self setEveryObjCObjectPropertyToNil];
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
	[super dismissModalViewControllerAnimated:animated];
}

- (void) tableView:(UITableView*)tv didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	if( indexPath.section == 1 && indexPath.row == 1 ) {
		if( self.datePicker == nil ) {
            static const int Dec_15_1970 = 61606800;
			self.datePicker = 
            [DatePickerViewController datePickerViewControllerWithDate:[NSDate dateWithTimeIntervalSince1970:Dec_15_1970] andTextField:self.dobCell.textField];
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
