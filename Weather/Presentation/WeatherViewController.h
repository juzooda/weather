//
//  WeatherViewController.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface WeatherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) City * selectedCity;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *convertorSegmentedControl;


@end
