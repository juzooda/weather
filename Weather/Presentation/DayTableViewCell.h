//
//  DayTableViewCell.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/14/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end
