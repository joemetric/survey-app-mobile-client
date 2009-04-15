#import "StaticTable.h"
@class LabelledTableViewCell;
@class MaleFemaleTableViewCell;

@interface EditProfileDataSource : StaticTable {
	LabelledTableViewCell* dobCell;
	LabelledTableViewCell* emailCell;
	LabelledTableViewCell* incomeCell;
	MaleFemaleTableViewCell* genderCell;
    UIViewController* parent;
    
}

+(id)editProfileDataSourceWithParentViewController:(UIViewController*)parent;
-(void)finishedEditing;


@property (nonatomic, retain)  LabelledTableViewCell* incomeCell;
@property (nonatomic, retain)  LabelledTableViewCell* emailCell;
@property (nonatomic, retain)  LabelledTableViewCell* dobCell;
@property (nonatomic, retain)  UIViewController* parent;
@property (nonatomic, retain)  MaleFemaleTableViewCell* genderCell;

@end
