//
//  CredentialsViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 13/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "CredentialsViewController.h"
#import "JoeMetricAppDelegate.h"
#import "Rest.h"
#import "RestConfiguration.h"
#import "Account.h"
#import "StaticTable.h"
#import "TableSection.h"
#import "LabelledTableViewCell.h"


@interface CredentialsViewController ()
@property(nonatomic, retain) LabelledTableViewCell* usernameCell;
@property(nonatomic, retain) LabelledTableViewCell* passwordCell;
@property(nonatomic, retain) StaticTable* staticTable;

@end

@implementation CredentialsViewController
@synthesize usernameCell, passwordCell, tableView, staticTable, activityIndicator;

-(void) viewDidLoad{
	self.staticTable = [StaticTable staticTable];

	TableSection* section = [TableSection tableSectionWithTitle:@"Enter existing credentials:"];
	[staticTable addSection:section];
	self.usernameCell = [LabelledTableViewCell loadLabelledCellWithOwner:self];
	self.passwordCell = [LabelledTableViewCell loadLabelledCellWithOwner:self];


	usernameCell.label.text = @"username";
    usernameCell.textField.delegate = self;
	usernameCell.textField.autocorrectionType = UITextAutocorrectionTypeNo;	
	usernameCell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;	

	passwordCell.textField.secureTextEntry = YES;	
	passwordCell.textField.autocorrectionType = UITextAutocorrectionTypeNo;	
	passwordCell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;	
	passwordCell.label.text = @"password";

	[section addCell:usernameCell];
	[section addCell:passwordCell];

	tableView.delegate = staticTable;
	tableView.dataSource = staticTable;
	tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [passwordCell.textField becomeFirstResponder];
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
	self.usernameCell.textField.text = [RestConfiguration username];
	self.passwordCell.textField.text = [RestConfiguration password];
}

- (IBAction) login:(id)sender {
	[self.activityIndicator startAnimating];
	[RestConfiguration setUsername:self.usernameCell.textField.text];
	[RestConfiguration setPassword:self.passwordCell.textField.text];
	[[Account currentAccount] onChangeNotifyObserver:self];
	[[Account currentAccount] loadCurrent];


}

-(void)setFooter:(NSString*)footer{
	[[staticTable sectionAtIndex:0] setFooterLine:footer];
}


-(void) changeInAccount:(Account*)account{
	[self.activityIndicator stopAnimating];
	[account noLongerNotifyObserver:self];
	switch(account.accountLoadStatus){
	case accountLoadStatusUnauthorized:
		[self setFooter:@"Wrong username or password."];
		break;
	case accountLoadStatusLoadFailed:
		[self setFooter:[NSString stringWithFormat:@"Error: %@", [account.lastLoadError localizedDescription]]];
		break;
	default:
		[self setFooter:@""];
		break;
	}
    [tableView reloadData];
}



- (IBAction) cancel:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}


@end
