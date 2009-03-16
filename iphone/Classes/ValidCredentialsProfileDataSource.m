//
//  ValidCredentialsProfileDataSource.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "ValidCredentialsProfileDataSource.h"
#import "ProfileViewController.h"

@implementation ValidCredentialsProfileDataSource
@synthesize profileViewController;

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
				cell.text = @"ZipCode: 61601";
				break;
			case 1:
				cell.text = @"Height: 6'3";
				break;
			case 2:
				cell.text = @"Hair: Long";
				break;
			case 3:
				cell.text = @"Facial Tatoos: Yes";
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
	[super dealloc];
}

@end
