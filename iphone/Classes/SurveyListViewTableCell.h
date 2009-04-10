//
//  SurveyListViewTableCell.h
//  JoeMetric
//
//  Created by Alan Francis on 09/04/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SurveyListViewTableCell : UITableViewCell {
	UILabel* surveyName;
	UILabel* surveyValue;
	UIImageView* lozengeView;
	
}

@property (nonatomic, retain) IBOutlet UILabel* surveyName;
@property (nonatomic, retain) IBOutlet UILabel* surveyValue;
@property (nonatomic, retain) IBOutlet UIImageView* lozengeView;

@end
