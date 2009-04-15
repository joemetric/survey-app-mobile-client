#import "StaticTable.h"
@class LabelledTableViewCell;
@class MaleFemaleTableViewCell;

@interface EditProfileDataSource : StaticTable {
	LabelledTableViewCell* dobCell;
	LabelledTableViewCell* emailCell;
	LabelledTableViewCell* incomeCell;
	MaleFemaleTableViewCell* genderCell;
    
}

@property (nonatomic, retain)  LabelledTableViewCell* incomeCell;
@property (nonatomic, retain)  LabelledTableViewCell* emailCell;
@property (nonatomic, retain)  LabelledTableViewCell* dobCell;
@property (nonatomic, retain)  IBOutlet MaleFemaleTableViewCell* genderCell;

@end
