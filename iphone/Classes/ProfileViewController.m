//
//  ProfileViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "JoeMetricAppDelegate.h"
#import "ProfileViewController.h"
#import "NoCredentialsProfileDataSource.h"
#import "NoAccountDataProfileDataSource.h"
#import "ValidCredentialsProfileDataSource.h"
#import "CredentialsViewController.h"
#import "NewAccountViewController.h"
#import "NSObject+CleanUpProperties.h"
#import "EditProfileDataSource.h"

@interface ProfileViewController (Private)
- (void) setTableDelegate;
@end

@implementation ProfileViewController
@synthesize currentDataSource, activityIndicator;


// Correct for navigation bar
-(NSInteger) tableShrinkingKeyboardHeightCorrection{
    return 55;
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	[[Account currentAccount] onChangeNotifyObserver:self];
    [self setTableDelegate];
	[super viewDidLoad];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	[self.tableView reloadData];
	[super dismissModalViewControllerAnimated:animated];
}

- (void) displayModalCredentialsController {
	CredentialsViewController* credentialsController = [[[CredentialsViewController alloc] initWithNibName:@"CredentialsView" bundle:nil] autorelease];
	[self presentModalViewController:credentialsController animated:YES];
}

- (void) displayModalNewAccountController {
	[self dismissModalViewControllerAnimated:YES];
	NewAccountViewController* newAccountController = [[[NewAccountViewController alloc] initWithNibName:@"NewAccountView" bundle:nil] autorelease];
	newAccountController.profileView = self;
	[self presentModalViewController:newAccountController animated:YES];
}

-(IBAction)refreshAccount{
	[activityIndicator startAnimating];
	[[Account currentAccount] loadCurrent];
}


- (void) setTableDelegate{
	if (self.isEditing){
		switch([Account currentAccount].accountLoadStatus){
			case accountLoadStatusFailedValidation:
			// Stay editing
			break;
			case accountLoadStatusLoaded:
			self.currentDataSource =  [ValidCredentialsProfileDataSource staticTableForTableView:tableView];			
			[super setEditing:NO animated:YES];
			break;
		}

	}
	else{
		switch([Account currentAccount].accountLoadStatus){
		case accountLoadStatusUnauthorized:
		case accountLoadStatusFailedValidation:
			self.currentDataSource = [NoCredentialsProfileDataSource noCredentialsProfileDataSourceForTableView:tableView profileViewController:self];
			break;
		case accountLoadStatusNotLoaded:
			self.currentDataSource =  [NoAccountDataProfileDataSource noAccountDataProfileDataSourceWithMessages:[NSArray arrayWithObject:@"Loading account details."] andTableView:tableView];
			break;
		case accountLoadStatusLoadFailed:
			self.currentDataSource = [NoAccountDataProfileDataSource 
				noAccountDataProfileDataSourceWithMessages:
					[NSArray arrayWithObjects:@"Unable to load account details:", 
					[[Account currentAccount].lastLoadError localizedDescription] ,nil] 
				andTableView:tableView];	
			break;
		default:
			self.navigationItem.leftBarButtonItem = self.editButtonItem;
			self.currentDataSource =  [ValidCredentialsProfileDataSource staticTableForTableView:tableView];			
			break;
		}
	}
}

-(void)changeInAccount:(Account*) _account{
	[activityIndicator stopAnimating];
	if (accountLoadStatusLoaded == [Account currentAccount].accountLoadStatus){
		[self dismissModalViewControllerAnimated:YES];
	}

    [self setTableDelegate];
	[self.tableView reloadData];
} 


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
	if(editing){
		self.currentDataSource = [EditProfileDataSource editProfileDataSourceWithParentViewController:self andTableView:tableView];
		[super setEditing:editing animated:animated];
	}
    else{
        [(EditProfileDataSource* )self.currentDataSource finishedEditing];
    }
	[tableView reloadData];
}

- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}
@end

