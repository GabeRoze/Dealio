//
//  DealListViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "FavoritesViewController.h"
#import "DealViewController.h"
#import "DealListViewCell.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "Models.h"
#import "UIAlertView+Blocks.h"
#import "Models.h"
#import "GRCustomSpinnerView.h"
#import "DealioService.h"

@implementation FavoritesViewController

@synthesize filterViewDisplayed;
@synthesize currentSelectedDay;
@synthesize listData;
@synthesize table;
@synthesize dealData;
@synthesize messageText;
@synthesize FAVORITES_MODE;
@synthesize parser;
@synthesize dealViewController;
@synthesize locationManager;
@synthesize currentLocation;
@synthesize saturdaybutton;
@synthesize sundayButton;
@synthesize mondayButton;
@synthesize tuesdayButton;
@synthesize wednesdayButton;
@synthesize thursdayButton;
@synthesize fridayButton;
@synthesize filterButton;
@synthesize filterBackground;
@synthesize sundayLabel;
@synthesize saturdayLabel;
@synthesize mondayLabel;
@synthesize tuesdayLabel;
@synthesize wednesdayLabel;
@synthesize thursdayLabel;
@synthesize fridayLabel;
@synthesize dayButtons;
@synthesize dayLabels;

static DealListViewController *instance;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    [navBarTitleLabel setFont:[UIFont fontWithName:@"Eurofurenceregular" size:navBarTitleLabel.font.pointSize]];

    firstLoadFinished = NO;

//    [self initFilterButton];
    [self initDayButtons];
    [self loadWithCurrentDay];
}

//Implement this to select the current day once the user logs out/in
-(void)viewDidAppear:(BOOL)animated
{
    firstLoadFinished = YES;
}

#pragma mark -
#pragma mark Handle UI Interation
-(void) reloadDataForInfo:(NSString *)data
{
    if (SearchLocation.instance.savedAddressCoordinate.latitude == 9999
            && SearchLocation.instance.savedAddressCoordinate.longitude == 9999
            && !SearchLocation.instance.useCurrentLocation
            || SearchLocation.instance.savedAddressString.length < 1
                    && firstLoadFinished
                    && !SearchLocation.instance.useCurrentLocation)
    {
        RIButtonItem *okayButton = [RIButtonItem item];
        okayButton.label = @"Okay";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Address"
                                                            message:@"Please enter another address"
                                                   cancelButtonItem:okayButton
                                                   otherButtonItems:nil];
        [alertView show];
        [self filterButtonTapped];
    }
    else
    {
        [self getDealListWithDay:data];
    }
}

-(void)getDealListWithDay:(NSString *)day
{
    [GRCustomSpinnerView.instance addSpinnerToView:self.view];

    [DealioService getFavoriteListForDay:day onSuccess:^(NSData *data){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            parser = [[XMLParser alloc] initXMLParser:data];
            DealData.instance.favoriteList = parser.dealListArray;
            DealData.instance.featuredDeal = parser.featuredDeal;

            dispatch_async( dispatch_get_main_queue(), ^{
                [table reloadData];
                [GRCustomSpinnerView.instance stopSpinner];
            });
        });

    } onFailure:nil];
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = DealData.instance.favoriteList.count;

    if (DealData.instance.featuredDeal)
    {
        rowCount++;
    }
    return rowCount;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = @"CellTableIdentifier";
    DealListViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

    if (!cell)
    {
        cell = [DealListViewCell new];
    }

    NSDictionary* rowData = nil;


    if (!firstLoadFinished)
    {
        rowData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Loading ...",@"businessname",
                                                                      @"", @"dealname",
                                                                      @"", @"distance",
                                                                      @"", @"numlikes", nil];
        cell.userInteractionEnabled = NO;
        cell.ratingLabel.text = @"";
        cell.distance = @"";
    }
    else if (DealData.instance.featuredDeal && indexPath.row == 0)
    {
        rowData = DealData.instance.featuredDeal;
        cell.featuredLabel.hidden = NO;
        [cell setFeaturedBackground];
        cell.userInteractionEnabled = YES;
    }
    else if (DealData.instance.featuredDeal && indexPath.row > 0)
    {
        rowData = [DealData.instance.favoriteList objectAtIndex:indexPath.row-1];
        cell.featuredLabel.hidden = YES;
        [cell setBackgroundWithPattern];
        cell.userInteractionEnabled = YES;
    }
    else
    {
        rowData = [DealData.instance.favoriteList objectAtIndex:indexPath.row];
        cell.featuredLabel.hidden = YES;
        [cell setBackgroundWithPattern];
        cell.userInteractionEnabled = YES;
    }

    if (firstLoadFinished)
    {
        cell.rating = [NSString stringWithFormat:@"%@ Love it!", [rowData objectForKey:@"numlikes"]];
        cell.distance = [CalculationHelper formatDistance:[rowData objectForKey:@"distance"]];
    }

    cell.restaurantName = [rowData objectForKey:@"businessname"];
    cell.dealName = [rowData objectForKey:@"dealname"];
    [cell setLogoWithString:(NSString*)[rowData objectForKey:@"logoname"]];

    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* rowData = nil;

    if (!firstLoadFinished)
    {
    }
    else if (DealData.instance.featuredDeal && indexPath.row == 0)
    {
        rowData = DealData.instance.featuredDeal;
    }
    else if (DealData.instance.featuredDeal && indexPath.row > 0)
    {
        rowData = [DealData.instance.favoriteList objectAtIndex:indexPath.row-1];
    }
    else
    {
        rowData = [DealData.instance.favoriteList objectAtIndex:indexPath.row];
    }

    self.dealViewController.dealListData = [NSMutableDictionary dictionaryWithDictionary:rowData];
    [self presentModalViewController:self.dealViewController animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Set cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark - Button Taps
-(void)filterButtonTapped
{
    if (!filterViewDisplayed)
    {
        filterViewDisplayed = YES;
        [self disableAllDays];
        [self.view addSubview:filterTableViewController.view];
        filterBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_dark.png"]];
    }
    else
    {
        filterViewDisplayed = NO;
        [filterTableViewController.view removeFromSuperview];
        filterBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_medium.png"]];
        [self highlightDay:currentSelectedDay];
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:currentSelectedDay]];
    }
}

-(void)highlightDay:(int)day
{
    UIImageView *selectedDayButton = (UIImageView *) [dayButtons objectAtIndex:day];
    UILabel *currentDayLabel = (UILabel *)[dayLabels objectAtIndex:day];

    //change selected day button to selected color
    selectedDayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_dark.png"]];
    [currentDayLabel setTextColor:[UIColor whiteColor]];
    self.currentSelectedDay = selectedDayButton.tag;
}

-(IBAction)dayButtonTapped:(id)sender
{
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIImageView *selectedDayButton = (UIImageView *) tapGestureRecognizer.view;

    //change all colors to normal
    [self disableAllDays];
    [self highlightDay:selectedDayButton.tag];

//    if (filterViewDisplayed)
//    {
//        [self filterButtonTapped];
//    }
//    else
//    {
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:selectedDayButton.tag]];
//    }
}

-(void)disableAllDays
{
    for (NSUInteger i = 0; i < [dayButtons count]; i++)
    {
        UIImageView *dayButton = [dayButtons objectAtIndex:i];
        dayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_medium.png"]];
        UILabel *dayLabel = (UILabel *)[dayLabels objectAtIndex:i];
        [dayLabel setTextColor:[UIColor brownColor]];
    }
}

#pragma mark - Class Initiation
-(void)initDayButtons
{
    dayButtons = [[NSMutableArray alloc] initWithObjects:sundayButton,
                                                         mondayButton,
                                                         tuesdayButton,
                                                         wednesdayButton,
                                                         thursdayButton,
                                                         fridayButton,
                                                         saturdaybutton,
                                                         nil];

    dayLabels = [[NSMutableArray alloc] initWithObjects:sundayLabel,
                                                        mondayLabel,
                                                        tuesdayLabel,
                                                        wednesdayLabel,
                                                        thursdayLabel,
                                                        fridayLabel,
                                                        saturdayLabel,
                                                        nil];

    for (NSUInteger i = 0; i < [dayButtons count]; i++)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayButtonTapped:)];
        UIImageView *dayButton = [dayButtons objectAtIndex:i];
        UILabel *currentDayLabel = (UILabel *)[dayLabels objectAtIndex:i];

        [dayButton addGestureRecognizer:tapGesture];
        dayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_medium.png"]];
        dayButton.tag = i;

        [currentDayLabel setFont:[UIFont systemFontOfSize:16]];
    }
}

/*
-(void)initFilterButton
{
    filterBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_medium.png"]];
    filterTableViewController = [FilterTableViewController new];

    CGRect frame = filterTableViewController.view.frame;
    frame.size.height = self.table.frame.size.height;
    frame.origin.y = self.table.frame.origin.y;
    filterTableViewController.view.frame = frame;

    filterViewDisplayed = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterButtonTapped)];
    [filterButton addGestureRecognizer:tapGesture];
}
*/

-(void)loadWithCurrentDay
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
            [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger weekday = [weekdayComponents weekday];
    UIImageView *currentDay = (UIImageView *)[dayButtons objectAtIndex:(weekday-1)];
    currentDay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_dark.png"]];
    UILabel *currentDayLabel = (UILabel *)[dayLabels objectAtIndex:(weekday-1)];
    [currentDayLabel setTextColor:[UIColor whiteColor]];

    //alloc required vars
    dealViewController = [DealViewController new];

    //Show loading bar and reload the data
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:(weekday-1)]];
    currentSelectedDay = weekday-1;
}

- (void)viewDidUnload
{
    [self setFilterBackground:nil];
    [super viewDidUnload];
}

@end
