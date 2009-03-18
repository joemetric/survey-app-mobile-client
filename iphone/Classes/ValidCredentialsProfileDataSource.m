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
#import "LabelledTableViewReadOnlyCell.h"

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

- (LabelledTableViewReadOnlyCell*) loadLabelledCell {
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LabelledTableViewReadOnlyCell" owner:self options:nil];
	return (LabelledTableViewReadOnlyCell*)[nib objectAtIndex:0];
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
	LabelledTableViewReadOnlyCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) { cell = [self loadLabelledCell];}
	// Configure the cell
	if( indexPath.section == 0 ) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textAlignment = UITextAlignmentCenter;
		cell.valueField.text = [NSString stringWithFormat:@"%@", account.username];
        cell.label.text = @"username";
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textAlignment = UITextAlignmentLeft;
		switch (indexPath.row) {
			case 0:
				cell.valueField.text =[NSString stringWithFormat:@"%@", account.email];
                cell.label.text = @"email";
				break;
			case 1:
				cell.valueField.text = [NSString stringWithFormat:@"%@", account.birthdate];
                cell.label.text = @"date of birth";
				break;
			case 2:
				cell.valueField.text = [NSString stringWithFormat:@"$%d", account.income];
                cell.label.text = @"income";
				break;
			case 3:
  				cell.valueField.text =[NSString stringWithFormat:@"%@", account.gender];
                cell.label.text = @"gender";
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
