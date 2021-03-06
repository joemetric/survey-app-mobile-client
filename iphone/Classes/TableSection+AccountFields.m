#import "TableSection+AccountFields.h"
#import "LabelledTableViewCell.h"
#import "MaleFemaleTableViewCell.h"

@implementation TableSection(AccountFields)

-(id)addAndReturnCell:(UITableViewCell*) cell{
	[self addCell:cell];
	return cell;
}

-(MaleFemaleTableViewCell*)addGenderCell{
    return [self addAndReturnCell:[MaleFemaleTableViewCell loadMaleFemaleTableViewCell]];
}

-(LabelledTableViewCell*)addLoginCell{
    return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
                                 withErrorField:@"login"] 
                                withLabelText:@"username"] 
                               withPlaceholder:@"joe"] 
                              withoutCorrections]];
}

-(LabelledTableViewCell*)addPasswordCell{
    return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
                                      withErrorField:@"password"] 
                                     withLabelText:@"password"] 
                                    withPlaceholder:@"min 6 chars"] 
                                   makeSecure]];
}

-(LabelledTableViewCell*)addPasswordConfirmationCell{
    return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
                                      withErrorField:@"password_confirmation"]
                                     withLabelText:@"confirm P/W"] 
                                    withPlaceholder:@"confirm password"] 
                                   makeSecure]];
}

-(LabelledTableViewCell*)addIncomeCell{
	return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
		withErrorField:@"income"] 
		withLabelText:@"income"] 
		withPlaceholder:@"999999"] 
		withKeyboardType:UIKeyboardTypeNumbersAndPunctuation]];
}

-(LabelledTableViewCell*)addDobCellWithParent:(UIViewController*)parent{
    static const int Dec_15_1971 = 61606800;
    return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
                                      withErrorField:@"birthdate"] 
                                     withLabelText:@"date of birth"] 
                                    withPlaceholder:@"15 Dec 1971"] 
                                   makeDateUsingParent:parent atInitialDate:[NSDate dateWithTimeIntervalSince1970:Dec_15_1971]]];
}

-(LabelledTableViewCell*)addEmailCell{
    return [self addAndReturnCell:[[[[[LabelledTableViewCell loadLabelledCell] 
                                      withErrorField:@"email"] 
                                     withLabelText:@"email"] 
                                    withPlaceholder:@"joe@example.com"] 
                                   makeEmail]];
}



@end



