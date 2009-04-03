//
//  NoCredentialsProfileDataSource.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NoCredentialsProfileDataSource.h"
#import "ProfileViewController.h"

@implementation NoCredentialsProfileDataSource
@synthesize profileViewController;

- (void) dealloc {
	[profileViewController release];
	[super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog(@"numberOf Sections!");
    return 1;
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return @"Account";
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	return @"\n\nWe don't seem to have valid account details\n\nPlease login to your account\nif you have one, or create a new account.";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	return profileViewController.accountSectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NoCredentialsCell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if( indexPath.row == 0 )
		cell.text = @"Login";
	else
		cell.text = @"Signup";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"SELECT");
	if( indexPath.row == 0 ) {
		[self.profileViewController displayModalCredentialsController];
	} else if( indexPath.row == 1 ) {
		[self.profileViewController displayModalNewAccountController];
	} 
}

@end
