//
//  LabelledTableViewCell.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "LabelledTableViewCell.h"


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

+(LabelledTableViewCell*) loadLabelledCellWithOwner:(id)owner {
	NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"LabelledTableViewCell" owner:owner options:nil];
	return (LabelledTableViewCell*)[nib objectAtIndex:0];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(BOOL)errorHighlighted{
    return label.textColor == [UIColor redColor];
}

-(void)setErrorHighlighted:(BOOL)highlighted{
    label.textColor = highlighted ? [UIColor redColor] : [UIColor blackColor];
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
