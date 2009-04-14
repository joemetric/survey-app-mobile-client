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
@synthesize activityIndicator, profileView, tableView;
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
    static const int Dec_15_1971 = 61606800;
	TableSection* section = [TableSection tableSectionWithTitle:@"Demographics"];
	[staticTable addSection:section];
	
	self.incomeCell = [[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"income"] 
		withLabelText:@"Income"] 
		withPlaceholder:@"999999"] 
		withKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
	self.dobCell= [[[[[LabelledTableViewCell loadLabelledCell] 
        withErrorField:@"birthdate"] 
		withLabelText:@"Birthdate"] 
		withPlaceholder:@"15 Dec 1971"] 
		makeDateUsingParent:self atInitialDate:[NSDate dateWithTimeIntervalSince1970:Dec_15_1971]];
    [section addCell:self.incomeCell];
	[section addCell:dobCell];
	[section addCell:genderCell];
}


-(void)viewDidLoad{
	self.staticTable = [StaticTable staticTableForTableView:tableView];
	tableView.delegate = staticTable;
	tableView.dataSource = staticTable;
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


-(NSDateFormatter*)dateFormatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	return dateFormatter;
	
}

- (void) dismissModalViewControllerAnimated:(BOOL) animated {
	[super dismissModalViewControllerAnimated:animated];
    [tableView reloadData];
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
