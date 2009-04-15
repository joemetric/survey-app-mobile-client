#import "TableSection.h"
@class MaleFemaleTableViewCell;
@class LabelledTableViewCell;

@interface TableSection(AccountFields)
-(MaleFemaleTableViewCell*)addGenderCell;
-(LabelledTableViewCell*)addLoginCell;
-(LabelledTableViewCell*)addPasswordCell;
-(LabelledTableViewCell*)addPasswordConfirmationCell;
-(LabelledTableViewCell*)addIncomeCell;
-(LabelledTableViewCell*)addDobCellWithParent:(UIViewController*)parent;
-(LabelledTableViewCell*)addEmailCell;


@end
