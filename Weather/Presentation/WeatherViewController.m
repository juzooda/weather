//
//  WeatherViewController.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "WeatherViewController.h"
#import "DayTableViewCell.h"
#import "DateFormatter.h"
#import "Weather.h"
#import "Constants.h"
#import "CityBO.h"
#import "BackgroungManager.h"
#import "UIImageView+AFNetworking.h"

#define MAS_SHORTHAND

@interface WeatherViewController()

@property (nonatomic, strong) NSMutableArray * datasource;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
@property (weak, nonatomic) IBOutlet UIView *tutorialView;


@property (strong, nonatomic) Weather * nowWeather;

@property (nonatomic) BOOL fahrenheit;

@end

@implementation WeatherViewController

#pragma mark - Life Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
//    [self addBlurEffect];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self hideViewElements:YES];
    [self.tutorialView setHidden:YES];
    
    self.selectedCity = [CityBO getSelected];
    
    if (self.selectedCity) {
        
        self.title = self.selectedCity.name;
        CityBO * cityBO = [[CityBO alloc] init];
        
        [cityBO weatherFrom:self.selectedCity withCompletionBlock:^(Weather * currentWeather, NSArray * weathers) {
            
            [self hideViewElements:NO];
            
            if (currentWeather) {
                self.nowWeather = currentWeather;
                [self updateInformation];
            }
            
            if (weathers && [weathers count]) {
                [self updateDataSource:weathers];
            }
        }];
        
    }else{
        
        [self hideViewElements:YES];
        [self.tutorialView setHidden:NO];
    }
}

#pragma mark - View Customization

-(void)hideViewElements:(BOOL)hide
{
    [self.tableView setHidden:hide];
    [self.convertorSegmentedControl setHidden:hide];
    [self.temperatureLabel setHidden:hide];
    [self.dayDescriptionLabel setHidden:hide];
    [self.currentTemperature setHidden:hide];
    [self.cityNameLabel setHidden:hide];
}

-(void)addBlurEffect
{
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView * visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    
    [self.backgroundImageView addSubview:visualEffectView];
}

#pragma mark - Data Controls

-(void)updateDataSource:(NSArray *)weathers
{
    self.datasource = [[NSMutableArray alloc] initWithArray:weathers];
    [self.tableView reloadData];
}

-(void)updateInformation
{
    [self.backgroundImageView setImage:[BackgroungManager imageForCondition:self.nowWeather.value]];
    
    NSNumber * temperature = self.fahrenheit ? self.nowWeather.temperatureF : self.nowWeather.temperatureC;

    [self.temperatureLabel setText:[NSString stringWithFormat:@"%@˚", temperature]];
    [self.dayDescriptionLabel setText:self.nowWeather.value];
    [self.cityNameLabel setText:self.nowWeather.city.name];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    Weather * weather = [self.datasource objectAtIndex:indexPath.row];
    NSDate * day = [DateFormatter dateFromString:weather.date withOffSet:weather.city.offset];
    [cell.dayLabel setText:[DateFormatter weekDayFromDate:day]];
    NSNumber * temperature = self.fahrenheit ? weather.temperatureF : weather.temperatureC;
    
    [cell.temperatureLabel setText:[NSString stringWithFormat:@"%@˚", temperature]];
    
    return cell;
}

#pragma mark - Actions

- (IBAction)convertTemperatureScale:(UISegmentedControl *)sender {
    
    self.fahrenheit = sender.selectedSegmentIndex == FAHRENHEIT ? YES : NO;
    
    [self.tableView reloadData];
    [self updateInformation];
}

@end
