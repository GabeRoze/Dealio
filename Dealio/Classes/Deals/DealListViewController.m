//
//  DealListViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealListViewController.h"
#import "DealViewController.h"
#import "DealListViewCell.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "BorderedSpinnerView.h"
#import <CoreLocation/CoreLocation.h>

@implementation DealListViewController

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
@synthesize sundayLabel;
@synthesize saturdayLabel;
@synthesize mondayLabel;
@synthesize tuesdayLabel;
@synthesize wednesdayLabel;
@synthesize thursdayLabel;
@synthesize fridayLabel;
@synthesize dayButtons;
@synthesize dayLabels;

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

    [self initDayButtons];

    // locationManager update as location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

    borderedSpinnerView = [[BorderedSpinnerView alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(favoritesButtonPressed:)
                                                 name:@"favoritesButtonPressed"
                                               object:nil];

    // Highlight current day on the tab bar
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
            [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger weekday = [weekdayComponents weekday];
//    [self selectDay:(weekday-1)];
    UIImageView *currentDay = (UIImageView *)[dayButtons objectAtIndex:(weekday-1)];
    currentDay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selected_day_button_color"]];

    //alloc required vars
    self.dealData = [[NSMutableArray alloc] init];
    dealViewController = [[DealViewController alloc] init];

    //Show loading bar and reload the data
    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:(weekday-1)]];
}

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

    dayLabels = [[NSMutableArray alloc] initWithObjects:mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel, nil];

    NSLog(@"day labels :%i", dayLabels.count);

    for (NSUInteger i = 0; i < [dayButtons count]; i++)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayButtonTapped:)];

        UIImageView *dayButton = [dayButtons objectAtIndex:i];

        [dayButton addGestureRecognizer:tapGesture];
        dayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
        dayButton.tag = i;

        UILabel *currentDayLabel = (UILabel *)[dayLabels objectAtIndex:i];
        [currentDayLabel setFont:[UIFont fontWithName:@"Eurofurenceregular" size:24]];
    }
}

//Implement this to select the current day once the user logs out/in
-(void)viewDidAppear:(BOOL)animated {

}
- (void)viewDidUnload
{
    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];
//    [self setDayControlBar:nil];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.listData = nil;
    self.dealData = nil;
    self.dayButtons = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Handle UI Interation
-(void) favoritesButtonPressed:(NSNotification*) notification
{
    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];

//    dayControlBar.momentary = YES;

    [self reloadDataForInfo:@"Favorites"];

    /*
     NSArray* data = [[NSArray alloc] initWithObjects:@"poop", nil];
     [self connectToServer:data];
     */
//    [dayControlBar setSelectedSegmentIndex:-1];
}

-(void) reloadDataForInfo:(NSString *)data
{
    //call server with day
    [self connectToServer:data];

    //if favorites:
    //still receive an array
}


-(IBAction)dayButtonTapped:(id)sender
{
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIImageView *selectedDayButton = (UIImageView *) tapGestureRecognizer.view;

    //change all colors to normal
    for (NSUInteger i = 0; i < [dayButtons count]; i++)
    {
        UIImageView *dayButton = [dayButtons objectAtIndex:i];
        dayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    }
    //change selected day button to selected color
    selectedDayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selected_day_button_color"]];

    //load new days data
    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:selectedDayButton.tag]];
    NSLog(@"SELECTED DAY IS %@", [CalculationHelper convertIntToDay:selectedDayButton.tag]);
}

#pragma mark -
#pragma mark Server Connectivity and XML
-(void) connectToServer:(NSString*)data {

    CLLocation *location = [locationManager location];

    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];

    currentLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];


    //attempt to connect to server
    NSString* urlAsString = @"";
    // NSString* emailString = [NSString stringWithFormat:@"?useremail=%@",(NSString*)[userData objectAtIndex:0] ];
    // NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
    NSString* currentDay = [NSString stringWithFormat:@"currentday=%@",data ];
    NSString *latitude = [NSString stringWithFormat:@"&userlat=%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"&userlong=%f", coordinate.longitude];
    NSString* maxDistance = [NSString stringWithFormat:@"&maxdistance=150.0"];

    urlAsString = [urlAsString stringByAppendingString:currentDay];
    urlAsString = [urlAsString stringByAppendingString:latitude];
    urlAsString = [urlAsString stringByAppendingString:longitude];
    urlAsString = [urlAsString stringByAppendingString:maxDistance];

    NSString* functionURL = @"http://www.cinnux.com/dealheader-func.php/";


    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];


    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

                      if ([data length] > 0 && error == nil) {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];

                          //NSLog (@"Deal List = %@", html);

                          // parse file
                          [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];

                      }
                      else if ([data length] == 0 && error == nil) {
                          //NSLog(@"Nothing was downloaded.");
                          messageText = @"Server not responding";
                          //[self stopSpinner];
                          [borderedSpinnerView.view removeFromSuperview];

                      }
                      else if (error != nil) {
                          //NSLog(@"Error happened = %@", error);
                          messageText = @"Error occured during login";
                          //[self stopSpinner];
                          [borderedSpinnerView.view removeFromSuperview];

                      }
                  }];

}


-(void) parseXMLFile:(NSData*)data {
    parser = [[XMLParser alloc] initXMLParser:data];

    dealData = [CalculationHelper sortAndFormatDealListData:parser.dealListArray atLocation:currentLocation];

    NSLog(@"DEAL DATA POST XML IS: %@", dealData);

    [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];
}


-(void) serverResponseAcquired {

    // set the deal data to the parsers data
    //dealData = parser.dealListArray;

    // reload the table
    [table reloadData];

    // stop spinner
    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];

}


#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return[self.dealData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Represents the type of or table cell
    static NSString* CellTableIdentifier = @"CellTableIdentifier";

    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib* nib = [UINib nibWithNibName:@"DealListViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }

    DealListViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

    NSUInteger row = [indexPath row];
    NSDictionary* rowData = [self.dealData objectAtIndex:row];

    cell.restaurantName = [rowData objectForKey:@"businessname"];
    cell.dealName = [rowData objectForKey:@"name"];

    NSString* dealRating = [CalculationHelper convertLikesToRating:[rowData objectForKey:@"like"] dislikes: [rowData objectForKey:@"dislike"]];

    cell.rating = dealRating;

    cell.distance = [rowData objectForKey:@"calculateddistance"];//[rowData objectForKey:@"distance"];

    NSString* dealTime = [CalculationHelper convert24HourTimesToString:[rowData objectForKey:@"starttime"] endTime:[rowData objectForKey:@"endtime"]];


    cell.dealTime = dealTime;
    //[cell setLogoWithString:[rowData objectForKey:@"logoname"]];

    [cell setLogoWithString:(NSString*)[rowData objectForKey:@"logoname"]];


    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    /*
     NSUInteger row = [indexPath row];
     //if first row is selected, no row should be selected
     if (row==0){
     //return nil;
     return indexPath;
     }
     */


    return indexPath;
}


//Implement row selection here
// Will create a new view with the deal
// Get the rows data
// Pass it to the new window (dealview)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {



    //Set up the deal info
    NSUInteger row = [indexPath row];

    NSDictionary* rowData = [self.dealData objectAtIndex:row];
    [self.dealViewController loadDealFromList:rowData];




    // NSLog(@"rowData: %@", rowData);

    [self presentModalViewController:self.dealViewController animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Set cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)loadImageToCellWithString:(NSArray*)array
{
    int cellPosition =  (int) [array objectAtIndex:1];

    NSIndexPath *a = [NSIndexPath indexPathForRow:cellPosition inSection:0]; // I wanted to update this cell specifically
    DealListViewCell *c = (DealListViewCell *)[table cellForRowAtIndexPath:a];


    //set logo on cell c with image name

    //NSLog(@"ADD THESE IMAGE w/data TO CELL! %@",array);
    [c setLogoWithString:(NSString*)[array objectAtIndex:0]];

    //call initialize on this cell

    [self performSelectorOnMainThread:@selector(refreshCellAtPosition:) withObject:[array objectAtIndex:1]  waitUntilDone:YES];


    //create cell with info
    //get image to download

    //create the cell
}


-(void)refreshCellAtPosition:(NSNumber*)num
{
    NSInteger rowInteger = [num integerValue];
    //NSLog(@"array int at index: %i",rowInteger);
    NSMutableArray* mutArray = [[NSMutableArray alloc] init];
    NSIndexPath* path = [NSIndexPath indexPathForRow:rowInteger inSection:0];
    [mutArray insertObject:path atIndex:0];
    //NSLog(@"array to reload: %@", mutArray);
    [self.table reloadRowsAtIndexPaths:mutArray withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark Spinner (defunct)
-(void) createAndDisplaySpinner
{
    if (spinner != nil)
    {
        [self stopSpinner];
    }

    //NSLog(@"spiner displayed");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(width/2.0 ,(height-44)/2.0)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    //[self.view setNeedsDisplay];

}

-(void) stopSpinner {

    //NSLog(@"spinner hidden");

    [spinner stopAnimating];
    [spinner removeFromSuperview];

}



@end
