//
//  CitiesTableViewController.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "City.h"
#import "CityBO.h"
#import "WeatherViewController.h"

@interface CitiesTableViewController()

@property (nonatomic, strong) NSMutableArray * datasource;

@end

@implementation CitiesTableViewController

#pragma mark - Life Cycle

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.datasource = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self updateDataSource];
    [self.tableView reloadData];
}

#pragma mark -

-(void) updateDataSource
{
    [self.datasource removeAllObjects];
    [self.datasource addObjectsFromArray:[CityBO all]];
}

#pragma mark - UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    City * city = [self.datasource objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:city.name];
    [cell.detailTextLabel setText:city.country];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City * city = [self.datasource objectAtIndex:indexPath.row];
    [CityBO setSelectedCity:city];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        City * city = [self.datasource objectAtIndex:indexPath.row];
        
        [CityBO remove:city];
        
        [self updateDataSource];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

@end
