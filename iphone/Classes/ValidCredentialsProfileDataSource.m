//
//  ValidCredentialsProfileDataSource.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "ValidCredentialsProfileDataSource.h"
#import "ProfileViewController.h"
#import "Account.h"

@implementation ValidCredentialsProfileDataSource
@synthesize profileViewController, account;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog(@"numberOf Sections!");
    return 2;
}

- (NSString*)tableView:(UITableView*) tv titleForHeaderInSection:(NSInteger) section {
	return section == 0 ? @"Account" : @"Demographic Data";
}

- (NSString*)tableView:(UITableView*) tv titleForFooterInSection:(NSInteger) section {
	return @"";
}

- (NSInteger)tableView:(UITableView *)yv numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) { cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];}
	// Configure the cell
	if( indexPath.section == 0 ) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textAlignment = UITextAlignmentCenter;
		cell.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textAlignment = UITextAlignmentLeft;
		switch (indexPath.row) {
			case 0:
				cell.text =[NSString stringWithFormat:@"%@", account.email];
				break;
			case 1:
				cell.text = [NSString stringWithFormat:@"%@", account.birthdate];
				break;
			case 2:
				cell.text = [NSString stringWithFormat:@"$%10d", account.income];
				break;
			case 3:
                NSLog(@"sex:%@", account.gender);
				cell.text =[NSString stringWithFormat:@"%@", account.gender];
                NSLog(@"sex:%@", cell.text);
				break;
			default:
				break;
		}
	}
	return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void) dealloc {
	[profileViewController release];
    [account release];
	[super dealloc];
}

@end
