//
//  NoCredentialsProfileDataSource.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "NoCredentialsProfileDataSource.h"
#import "ProfileViewController.h"
#import "TableSection.h"

@implementation NoCredentialsProfileDataSource
@synthesize profileViewController;


-(UITableViewCell*) cellWithText:(NSString*)text{
	UITableViewCell* cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"NoCredentialsCell"] autorelease];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.text = text;
	return cell;
}


-(id)init{
	[super init];
	TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
	[self addSection:section];
	[section addCell:[self cellWithText:@"Login"]];
	[section addCell:[self cellWithText:@"Signup"]];
	[section setFooterLines:[NSArray arrayWithObjects:@"We don't seem to have valid account details", @"Please login to your account if you have one or create a new account.", nil]];
	return self;
}

- (void) dealloc {
	[profileViewController release];
	[super dealloc];
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
