//
//  DealListViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FavoritesViewController.h"
#import "DealViewController.h"
#import "DealListViewCell.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "BorderedSpinnerView.h"
#import "Models.h"
#import "UIAlertView+Blocks.h"

@implementation FavoritesViewController

@synthesize currentSelectedDay;
@synthesize listData;
@synthesize table;
@synthesize dealData;
@synthesize messageText;
@synthesize FAVORITES_MODE;
@synthesize parser;
@synthesize dealViewController;
@synthesize borderedSpinnerView;
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

    firstLoadFinished = NO;
    instance = self;

    [self initFilterButton];
    [self initDayButtons];

    borderedSpinnerView = [[BorderedSpinnerView alloc] init];

    [self loadWithCurrentDay];
}

//Implement this to select the current day once the user logs out/in
-(void)viewDidAppear:(BOOL)animated
{
    firstLoadFinished = YES;
}
/* only called when memory is low
- (void)viewDidUnload
{
    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];
    [self setTable:nil];
    [self setSaturdaybutton:nil];
    [self setSundayButton:nil];
    [self setMondayButton:nil];
    [self setMondayButton:nil];
    [self setTuesdayButton:nil];
    [self setWednesdayButton:nil];
    [self setThursdayButton:nil];
    [self setFridayButton:nil];
    [self setSundayLabel:nil];
    [self setMondayLabel:nil];
    [self setTuesdayLabel:nil];
    [self setWednesdayLabel:nil];
    [self setThursdayLabel:nil];
    [self setFridayLabel:nil];
    [self setSundayLabel:nil];
    [self setSaturdayLabel:nil];
    [self setFilterButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.listData = nil;
    self.dealData = nil;
    self.dayButtons = nil;
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];
        [self connectToServer:data];
    }
}

#pragma mark -
#pragma mark Server Connectivity and XML
-(void) connectToServer:(NSString*)data
{
    CLLocationCoordinate2D coordinate = SearchLocation.instance.getLocation;

    NSString* urlAsString = @"";
    // NSString* emailString = [NSString stringWithFormat:@"?useremail=%@",(NSString*)[userData objectAtIndex:0] ];
    // NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
    NSString* currentDay = [NSString stringWithFormat:@"currentday=%@",data];
    NSString *latitude = [NSString stringWithFormat:@"&userlat=%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"&userlong=%f", coordinate.longitude];
    NSString* maxDistance = [NSString stringWithFormat:@"&maxdistance=%i", FilterData.instance.maximumSearchDistance];

    urlAsString = [urlAsString stringByAppendingString:currentDay];
    urlAsString = [urlAsString stringByAppendingString:latitude];
    urlAsString = [urlAsString stringByAppendingString:longitude];
    urlAsString = [urlAsString stringByAppendingString:maxDistance];

    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newdealheader-func.php/";

    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error)
                  {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
//                          NSLog(@"html %@", html);
                          [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];
                      }
                      else if ([data length] == 0 && error == nil)
                      {
                          messageText = @"Server not responding";
                          [borderedSpinnerView.view removeFromSuperview];

                      }
                      else if (error != nil)
                      {
                          messageText = @"Error occured during login";
                          [borderedSpinnerView.view removeFromSuperview];
                      }
                  }];

}

-(void) parseXMLFile:(NSData*)data
{
    parser = [[XMLParser alloc] initXMLParser:data];
    SearchLocation.instance.savedAddressCoordinate;
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:<#(CLLocationDegrees)latitude#> longitude:<#(CLLocationDegrees)longitude#>]
    //todo remove use of at
    dealData = [CalculationHelper sortAndFormatDealListData:parser.dealListArray atLocation:currentLocation];
    [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];
}

-(void) serverResponseAcquired
{
    [table reloadData];
    [borderedSpinnerView.view removeFromSuperview];
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dealData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = @"CellTableIdentifier";

    static BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib* nib = [UINib nibWithNibName:@"DealListViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }

    DealListViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

    NSUInteger row = [indexPath row];
    NSDictionary* rowData = [self.dealData objectAtIndex:row];

    cell.restaurantName = [rowData objectForKey:@"businessname"];
    cell.dealName = [rowData objectForKey:@"dealname"];

//    NSString* dealRating = [CalculationHelper convertLikesToRating:[rowData objectForKey:@"numlikes"] dislikes: [rowData objectForKey:@"dislike"]];

    cell.rating = [NSString stringWithFormat:@"%@ Love it!", [rowData objectForKey:@"numlikes"]];
    cell.distance = [rowData objectForKey:@"distance"];//[rowData objectForKey:@"distance"];
    [cell setLogoWithString:(NSString*)[rowData objectForKey:@"logoname"]];

    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];

    NSDictionary* rowData = [self.dealData objectAtIndex:row];
    [self.dealViewController loadDealFromList:rowData];

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
    //todo bug - deselect filter button doesn't highlight a day - should reload page
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
    if (filterViewDisplayed)
    {
        [self filterButtonTapped];
    }

    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIImageView *selectedDayButton = (UIImageView *) tapGestureRecognizer.view;
//    UILabel *currentDayLabel = (UILabel *)[dayLabels objectAtIndex:selectedDayButton.tag];

    //change all colors to normal
    [self disableAllDays];
    [self highlightDay:selectedDayButton.tag];

    //change selected day button to selected color
//    selectedDayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_dark.png"]];
//    [currentDayLabel setTextColor:[UIColor whiteColor]];

    //load new days data
//    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:selectedDayButton.tag]];
//    [self reloadDataForInfo:[NSString stringWithFormat:@"%i",selectedDayButton.tag]];
//    self.currentSelectedDay = selectedDayButton.tag;
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

-(void)favoritesButtonPressed:(NSNotification*) notification
{
//    [borderedSpinnerView.view removeFromSuperview];
    [borderedSpinnerView stopSpinner];
    [self reloadDataForInfo:@"Favorites"];
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

-(void)initFilterButton
{
    filterBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_medium.png"]];
    filterTableViewController = [FilterTableViewController new];

//    filterTableViewController = [[FilterTableViewController alloc] initWithDealListViewController:self];
    CGRect frame = filterTableViewController.view.frame;
    frame.size.height = self.table.frame.size.height;
    frame.origin.y = self.table.frame.origin.y;
    filterTableViewController.view.frame = frame;

    filterViewDisplayed = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterButtonTapped)];
    [filterButton addGestureRecognizer:tapGesture];
}

-(void)loadWithCurrentDay
{
    // Highlight current day on the tab bar
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
    self.dealData = [[NSMutableArray alloc] init];
    dealViewController = [[DealViewController alloc] init];

    //Show loading bar and reload the data
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:(weekday-1)]];
    currentSelectedDay = weekday-1;
}

- (void)viewDidUnload
{
    [self setFilterBackground:nil];
    [super viewDidUnload];
}


#pragma mark - Singleton
+(DealListViewController *)instance
{
    if (!instance)
    {
        return [DealListViewController new];
    }
    return instance;
}

@end