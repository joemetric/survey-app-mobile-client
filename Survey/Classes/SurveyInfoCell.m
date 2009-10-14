//
//  SurveyInfoCell.m
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "SurveyInfoCell.h"
#import "Survey.h"


@implementation SurveyInfoCell
@synthesize priceButton, nameLabel, descriptionLabel, takeButton;
@synthesize survey;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
	nameLabel.numberOfLines = 10;
	descriptionLabel.numberOfLines = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[priceButton release];
	[nameLabel release];
	[descriptionLabel release];
	[takeButton release];
	[survey release];
	
    [super dealloc];
}

- (void)updateSurvey:(Survey *)s {
	self.survey = s;
	CGSize textSize = { 230, 20000.0f };
	CGSize nameSize = [survey.name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	CGRect nameFrame = nameLabel.frame;
	nameFrame.size.height = nameSize.height + 4;
	[nameLabel setFrame:nameFrame];
	CGSize descriptionSize = [survey.description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	CGRect descFrame = descriptionLabel.frame;
	descFrame.size.height = descriptionSize.height + 4;
	[descriptionLabel setFrame:descFrame];
	CGRect takeFrame = takeButton.frame;
	takeFrame.origin.y = descFrame.origin.y + descFrame.size.height + 4;
	[takeButton setFrame:takeFrame];
	nameLabel.text = self.survey.name;
	descriptionLabel.text = self.survey.description;
}

@end
