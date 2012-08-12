//
//  FiltersViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "FiltersViewController.h"
#import "FilterViewCell.h"
#import "UserManager.h"
#import "EditProfileViewController.h"
 
@implementation FiltersViewController

@synthesize controllers;
@synthesize editProfileViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.title=@"First Level";
    NSMutableArray* array = [[NSMutableArray alloc] init];
    self.controllers = array;
    editProfileViewController = [[EditProfileViewController alloc] init];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.controllers = nil;
}

/*
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }*/


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

#pragma mark-
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
            
        case 0:
            return 3;
            break;
            
            
        case 1:
            return 15;
            break;
            
        case 2:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
    
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Price Range";
            break;
            
            
            
        case 1:
            return @"Cuisine Types";
            break;
            
            
            
        default:
            break;
    }
    
    return @"";
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //   static NSString* FirstLevelCell = @"FirstLevelCell";
    //    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    
    
    static NSString* filterViewCell = @"FilterViewCell";
    static NSString* defaultViewCell = @"DefaultViewCell";
    
    UITableViewCell* cell;
    
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered){
        
        UINib* filterViewNib = [UINib nibWithNibName:@"FilterViewCell" bundle:nil];
        
        [tableView registerNib:filterViewNib forCellReuseIdentifier:filterViewCell];
        
        nibsRegistered = YES;
        
    }
    
    
    /*
     
     create an array that contains the price options as a string
     create an array that contains the cuisine options as a string
     
     first section
     iterate through price options string
     create a custom filterviewcell
     assign it a name with the array
     
     
     */
    
    
    switch (indexPath.section) {
            
        case 0:
            
            if (indexPath.row == 0) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getPriceOption:@"$"];
                    cell1.filterTitleLabel.text = @"$";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            if (indexPath.row == 1) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getPriceOption:@"$$"];
                    cell1.filterTitleLabel.text = @"$$";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 2) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getPriceOption:@"$$$"];
                    cell1.filterTitleLabel.text = @"$$$";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            break;
            
            
            
            
        case 1:
            
            if (indexPath.row == 0) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"American"];
                    cell1.filterTitleLabel.text = @"American";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            
            if (indexPath.row == 1) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Cafe"];
                    cell1.filterTitleLabel.text = @"Cafe";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 2) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Chinese"];
                    cell1.filterTitleLabel.text = @"Chinese";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 3) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Korean"];
                    cell1.filterTitleLabel.text = @"Korean";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 4) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Bar/Alcohol"];
                    cell1.filterTitleLabel.text = @"Bar/Alcohol";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 5) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Dessert"];
                    cell1.filterTitleLabel.text = @"Dessert";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 6) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Fast Food"];
                    cell1.filterTitleLabel.text = @"Fast Food";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 7) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"French"];
                    cell1.filterTitleLabel.text = @"French";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 8) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Indian"];
                    cell1.filterTitleLabel.text = @"Indian";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 9) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Italian"];
                    cell1.filterTitleLabel.text = @"Italian";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 10) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Japanese"];
                    cell1.filterTitleLabel.text = @"Japanese";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 11) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Vietnamese/Thai"];
                    cell1.filterTitleLabel.text = @"Vietnamese/Thai";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 12) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Greek"];
                    cell1.filterTitleLabel.text = @"Greek";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 13) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"International"];
                    cell1.filterTitleLabel.text = @"International";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            
            
            if (indexPath.row == 14) {
                
                
                FilterViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell"];
                
                
                if (!cell1) {
                    cell = [[FilterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FilterViewCell"];
                }
                else {
                    NSString* state;
                    state = [[UserManager sharedManager] getCuisineOption:@"Vegetarian"];
                    cell1.filterTitleLabel.text = @"Vegetarian";
                    
                    if ([state isEqualToString:@"YES"]){
                        [cell1 setFilterStatus:YES];
                    }
                    else {
                        [cell1 setFilterStatus:NO];
                    }
                    
                    cell = cell1;
                }
            }
            break;
            
        case 2:
            
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:defaultViewCell];
                
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultViewCell];
                    cell.textLabel.text = @"Reset to Defaults";
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                }
                
            }
            
            
            
            break;
            
        default:
            break;
    }
    
    
    return cell;
    
    
    
    
    
    
    
    
    /*
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell];
     }
     
     //Configure the cell
     NSUInteger row = [indexPath row];
     SecondLevelViewController* controller = [controllers objectAtIndex:row];
     cell.textLabel.text = controller.title;
     cell.imageView.image = controller.rowImage;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     
     return cell;*/
}



#pragma mark -
#pragma mark Table View Delegate Methods

/*
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 NSUInteger row= [indexPath row];
 SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
 [self.navigationController pushViewController:nextController animated:YES];
 }
 */



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"Section:%i Row:%i",indexPath.section, indexPath.row);
    
    if (indexPath.section == 0 || indexPath.section == 1)
    {
        NSIndexPath* a = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        FilterViewCell* cell = (FilterViewCell*)[tableView cellForRowAtIndexPath:a];
        NSString* selectedCellText;
        selectedCellText = cell.filterTitleLabel.text;
        //NSLog(@"Selected text:%@",selectedCellText);
        BOOL oldStatus = cell.filterStatus;
        BOOL newStatus;
        
        if (oldStatus == YES) {
            [cell setFilterStatus:NO];
            newStatus = NO;
            
            
            if (indexPath.section == 0) {
                [[UserManager sharedManager] setPriceOption:selectedCellText toState:@"NO"];   
            }
            else if (indexPath.section == 1){
                [[UserManager sharedManager] setCuisineOption:selectedCellText toState:@"NO"];   
            }
         
            
        }
        else {
            [cell setFilterStatus:YES];
            newStatus = YES;
            
            if (indexPath.section == 0) {
                [[UserManager sharedManager] setPriceOption:selectedCellText toState:@"YES"];   
            }
            else if (indexPath.section == 1){
                [[UserManager sharedManager] setCuisineOption:selectedCellText toState:@"YES"];   
            }
            
        }
    }
    
    else {
        // reset was caleld
        // reset everything!
        
        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < 15; j++)
            {
                NSIndexPath* a = [NSIndexPath indexPathForRow:j inSection:i];
                FilterViewCell* cell = (FilterViewCell*)[tableView cellForRowAtIndexPath:a];
                [cell setFilterStatus:YES];
            }
        }
        [[UserManager sharedManager] resetFilters];
    }
    
}

/*
 -(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {  
 
 // NSLog(@"Section:%i Row:%i",indexPath.section, indexPath.row);
 }
 */



- (IBAction)userProfileButtonPressed:(id)sender {
        [self presentModalViewController:editProfileViewController animated:YES];
    //NSLog(@"it was pressed zomg!");
}
@end
