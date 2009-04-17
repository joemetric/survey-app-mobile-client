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
#import "TableSection.h"

@interface ValidCredentialsProfileDataSource()
@property (nonatomic, retain) Account *account;
@end

@implementation ValidCredentialsProfileDataSource
@synthesize profileViewController, account;

- (LabelledTableViewReadOnlyCell*) loadLabelledCell {
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LabelledTableViewReadOnlyCell" owner:self options:nil];
	return (LabelledTableViewReadOnlyCell*)[nib objectAtIndex:0];
}

-(UITableViewCell*)cellWithLabel:(NSString*) label text:(NSString*)text{
	LabelledTableViewReadOnlyCell* cell = [self loadLabelledCell];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textAlignment = UITextAlignmentLeft;
	cell.label.text = label;
	cell.valueField.text = text;
	return cell;
}


-(NSString*) formattedBirthDate{
	NSString* formattedDate =  [dateFormatter stringFromDate:account.birthdate];
	return nil == formattedDate ? @"" : formattedDate;
}

-(NSString*) formattedIncome{
	return [numberFormatter stringFromNumber:[NSNumber numberWithInteger:account.income]];
}

-(NSString*)formattedGender{
	return  account.isFemale ? @"Female" : @"Male";
}




-(TableSection*)createAccountSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
	[section addCell:[self cellWithLabel:@"username" text:account.username]];	
	return section;
}

-(TableSection*)createDemographicsSection{
	TableSection* section = [TableSection tableSectionWithTitle:@"Demographics"];
	[section addCell:[self cellWithLabel:@"email" text:account.email]];	
	[section addCell:[self cellWithLabel:@"income" text:[self formattedIncome]]];	
	[section addCell:[self cellWithLabel:@"date of birth" text:[self formattedBirthDate]]];	
	[section addCell:[self cellWithLabel:@"gender" text:[self formattedGender]]];	
	return section;
}


-(void)populate{
	[self removeAllSections];
	[self addSection:[self createAccountSection]];
	[self addSection:[self createDemographicsSection]];
}

-(void) changeInAccount:(Account*)account{
	[self populate];
}

-(id) init{
	[super init];
	numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setCurrencySymbol:@"$"];
    [numberFormatter setMaximumFractionDigits:0];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat =  @"dd MMM yyyy";
	self.account = [Account currentAccount];
	[self populate];
	[account onChangeNotifyObserver:self];
	return self;
}




- (void) dealloc {
	[numberFormatter release];
	[dateFormatter release];
	[profileViewController release];
    self.account = nil;
	[super dealloc];
}

@end
