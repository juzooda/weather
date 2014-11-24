//
//  SearchTableViewController.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "SearchTableViewController.h"
#import "CityBO.h"
#import "Constants.h"
#import "WeatherViewController.h"


@interface SearchTableViewController()

@property (nonatomic, strong) NSArray * datasource;

@end

@implementation SearchTableViewController{
    
    CityBO * cityBO;
}

#pragma mark - Life Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    cityBO = [[CityBO alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addCityCell"];
    
    NSDictionary * cityRepresentation = [self.datasource objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[cityRepresentation objectForKey:kCityName]];
    [cell.detailTextLabel setText:[cityRepresentation objectForKey:kCityCountry]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City * city = [CityBO addWithRepresentation:[self.datasource objectAtIndex:indexPath.row]];
    [CityBO setSelectedCity:city];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [cityBO executeRequestByCityName:searchText withCompletionBlock:^(NSArray *cities) {
        
        self.datasource = cities;
        [self.tableView reloadData];
        
    }];
}

@end
