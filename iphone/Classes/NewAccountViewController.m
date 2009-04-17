//
//  NewAccountViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "MaleFemaleTableViewCell.h"
#import "DatePickerViewController.h"
#import "Account.h"
#import "RestConfiguration.h"
#import "StaticTable.h"
#import "TableSection.h"
#import "NSObject+CleanUpProperties.h"
#import "TableSection+AccountFields.h"

@interface NewAccountViewController ()
@property(readonly) NSDictionary* errors;
@property(nonatomic, retain) StaticTable* staticTable;
@end

@implementation NewAccountViewController
@synthesize activityIndicator, profileView;
@synthesize  dobCell, genderCell, loginCell, emailCell, passwordCell, passwordConfirmationCell, incomeCell;
@synthesize staticTable;

@synthesize keyboardIsShowing;

-(void)populateBasicSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Basics"];
	[staticTable addSection:section];
	
	self.loginCell = [section addLoginCell];
	self.passwordCell= [section addPasswordCell];
	self.passwordConfirmationCell= [section addPasswordConfirmationCell];
	self.emailCell = [section addEmailCell];
}

-(void)populateDemographicsSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Demographics"];
	[staticTable addSection:section];
	
	self.incomeCell = [section addIncomeCell];
	self.dobCell= [section addDobCellWithParent:self];
	self.genderCell = [section addGenderCell];
}


-(void)viewDidLoad{
	self.staticTable = [StaticTable staticTableForTableView:tableView];
    [dobCell withErrorField:@"birthdate"];
	[self populateBasicSection];
	[self populateDemographicsSection];
	[[Account currentAccount] onChangeNotifyObserver:self];
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
	account.gender = genderCell.gender;
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
