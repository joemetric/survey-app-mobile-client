//
//  LabelledTableViewCell.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "LabelledTableViewCell.h"
#import "LoadsSingleObjectFromNib.h"



@implementation LabelledTableViewCell
@synthesize label, textField;
@synthesize tableView;
@synthesize errorField;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

+(LabelledTableViewCell*) loadLabelledCell {
	return [LoadsSingleObjectFromNib loadFromNib:@"LabelledTableViewCell"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (selected) [self.textField becomeFirstResponder];
    [super setSelected:selected animated:animated];
}


-(LabelledTableViewCell*)withLabelText:(NSString*)text{
	label.text = text;
	return self;
}


-(BOOL)errorHighlighted{
    return label.textColor == [UIColor redColor];
}

-(LabelledTableViewCell*)makeSecure{
    textField.secureTextEntry = YES;
	return self;
}

-(LabelledTableViewCell*)withoutCorrections{
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	return self;
}
-(LabelledTableViewCell*)makeEmail{
	return [[self withoutCorrections] withKeyboardType:UIKeyboardTypeEmailAddress];
}

-(LabelledTableViewCell*)withKeyboardType:(UIKeyboardType)keyboardType{
	textField.keyboardType = UIKeyboardTypeEmailAddress;
	return self;
}


-(void)setErrorHighlighted:(BOOL)highlighted{
    label.textColor = highlighted ? [UIColor redColor] : [UIColor blackColor];
}

-(void)activateEditing{
    [self.textField becomeFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField*)tf {
	[tf resignFirstResponder];
	return YES;
}

- (void)dealloc {
	[label release];
	[textField release];
	[tableView release];
    [super dealloc];
}


@end
