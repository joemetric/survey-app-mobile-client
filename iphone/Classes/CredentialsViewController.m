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
- (void) clearCredentials;
- (void) dummyCallback:(NSData*)testData;
@property(nonatomic, retain) LabelledTableViewCell* usernameCell;
@property(nonatomic, retain) LabelledTableViewCell* passwordCell;
@property(nonatomic, retain) StaticTable* staticTable;

@end

@implementation CredentialsViewController
@synthesize username, password, profileView, errorLabel, activityIndicator;
@synthesize usernameCell, passwordCell, tableView, staticTable;

-(void) viewDidLoad{
	self.staticTable = [StaticTable staticTable];

	TableSection* section = [TableSection tableSectionWithTitle:@"Enter existing credentials:"];
	[staticTable addSection:section];
	self.usernameCell = [LabelledTableViewCell loadLabelledCellWithOwner:self];
	self.passwordCell = [LabelledTableViewCell loadLabelledCellWithOwner:self];


	usernameCell.label.text = @"username";
	passwordCell.label.text = @"password";

	[section addCell:usernameCell];
	[section addCell:passwordCell];

	tableView.delegate = staticTable;
	tableView.dataSource = staticTable;
	tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

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
		[self setFooter:@"FISH"];
		break;
	}
    [tableView reloadData];
}


- (NSURLCredential *)getCredential {
	NSLog(@"getCredential");
	return [NSURLCredential credentialWithUser:self.username.text
		password:self.password.text
		persistence:NSURLCredentialPersistenceNone];	
}

- (void)authenticationFailed {
	NSLog(@"authenticationFailed");
	self.errorLabel.text = @"Invalid login details";
	[self.activityIndicator stopAnimating];
}

- (void) dummyCallback:(NSData*)testData {
	NSLog(@"dummyCallback: %@", [[[NSString alloc] initWithBytes:testData.bytes length:testData.length encoding:NSUTF8StringEncoding] autorelease]);
}

- (void) receivedTestData:(NSData*)testData {
	NSLog(@"receivedTestData: %@", [[[NSString alloc] initWithBytes:testData.bytes length:testData.length encoding:NSUTF8StringEncoding] autorelease]);

	[RestConfiguration setPassword:password.text];
	[RestConfiguration setUsername:username.text];
	[[Account currentAccount] loadCurrent];

	self.errorLabel.text = @"";
	[self.activityIndicator stopAnimating];
	[self.profileView dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender {
	[self.profileView dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[profileView release];
	[errorLabel release];
	[activityIndicator release];
	[username release];
	[password release];
	self.tableView = nil;
	[super dealloc];
}


@end
