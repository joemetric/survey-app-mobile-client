#import "EditProfileDataSource.h"
#import "TableSection.h"
#import "NSObject+CleanUpProperties.h"
#import "LabelledTableViewCell.h"
#import "MaleFemaleTableViewCell.h"
#import "Account.h"
#import "TableSection+AccountFields.h"

@implementation EditProfileDataSource
@synthesize emailCell, incomeCell, dobCell, genderCell, parent;



-(void)addAccountSection{
    TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
    [self addSection:section];
    LabelledTableViewCell* account = [section addLoginCell];
    account.textField.enabled = false;
}

-(void)addDemographicsSection{
    TableSection* section = [TableSection tableSectionWithTitle:@"Account"];
    [self addSection:section];
    self.emailCell = [section addEmailCell];
    self.incomeCell = [section addIncomeCell];
    self.dobCell = [section addDobCellWithParent:parent];
    self.genderCell = [section addGenderCell];
}

-(void)finishedEditing{
	[[Account currentAccount] update];
	[self resignFirstResponder];
	
}


-(void)populate{
    [self addAccountSection];
    [self addDemographicsSection];
}


+(id)editProfileDataSourceWithParentViewController:(UIViewController*)parent{
    EditProfileDataSource* result = [self staticTableForTableView:nil];
    result.parent = parent;
    [result populate];
    return result;
}


-(void) dealloc{
    [self setEveryObjCObjectPropertyToNil];
    [super dealloc];
}


@end
