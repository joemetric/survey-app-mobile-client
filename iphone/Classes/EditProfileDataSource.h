#import "StaticTable.h"
#import "Account.h"
@class LabelledTableViewCell;
@class MaleFemaleTableViewCell;

@interface EditProfileDataSource : StaticTable<AccountObserver> {
	LabelledTableViewCell* dobCell;
	LabelledTableViewCell* emailCell;
	LabelledTableViewCell* incomeCell;
    LabelledTableViewCell* loginCell;
	MaleFemaleTableViewCell* genderCell;
    UIViewController* parent;
    
}

+(id)editProfileDataSourceWithParentViewController:(UIViewController*)parent andTableView:(UITableView*)tableView;
-(void)finishedEditing;


@property (nonatomic, retain)  LabelledTableViewCell* loginCell;
@property (nonatomic, retain)  LabelledTableViewCell* incomeCell;
@property (nonatomic, retain)  LabelledTableViewCell* emailCell;
@property (nonatomic, retain)  LabelledTableViewCell* dobCell;
@property (nonatomic, retain)  UIViewController* parent;
@property (nonatomic, retain)  MaleFemaleTableViewCell* genderCell;

@end
