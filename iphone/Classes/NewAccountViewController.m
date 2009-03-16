//
//  NewAccountViewController.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NewAccountViewController.h"
#import "LabelledTableViewCell.h"
#import "Account.h"


@implementation NewAccountViewController
@synthesize username, password, emailAddress, gender, dob, income;
@synthesize activityIndicator, errorLabel, profileView, tableView;

- (void)dealloc {
	[tableView release];
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
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LabelledTableViewCell" owner:self options:nil];
	LabelledTableViewCell* cell = (LabelledTableViewCell*)[nib objectAtIndex:0];

	if( indexPath.section == 0 )
	{
		if( indexPath.row == 0 ) {
			cell.label.text = @"Username";
			self.username = cell.textField;
		}
		else if( indexPath.row == 1) {
			cell.label.text = @"Password";
			self.password = cell.textField;
		}
		else {
			cell.label.text = @"Email";			
			self.emailAddress = cell.textField;
		}
	} else {
		if( indexPath.row == 0 ) {
			cell.label.text = @"Date of Birth";
			self.dob = cell.textField;
		}
		else if( indexPath.row == 1) {
			cell.label.text = @"Income";
			self.income = cell.textField;
		}
		else {
			cell.label.text = @"Gender";	
			self.gender = cell.textField;
		}
		
	}
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
    Account *account = [Account createWithParams:params];
	[self.activityIndicator stopAnimating];
    if (account) {
		[[NSUserDefaults standardUserDefaults] setObject:username.text forKey:@"username"];
		[[NSUserDefaults standardUserDefaults] setObject:password.text forKey:@"password"];
		[self.profileView dismissModalViewControllerAnimated:YES];
    } else {
		UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Account Creation Failed" message:@"We were unable to create an account with those details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
    }	
}

- (IBAction) cancel {
	[self.profileView dismissModalViewControllerAnimated:YES];
}


@end
