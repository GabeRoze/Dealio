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
#import "DayControlBar.h"


@implementation DealListViewController

@synthesize listData;
@synthesize dayControlBar;
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
@synthesize dayButtons;

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

    dayButtons = [[NSMutableArray alloc] initWithObjects:sundayButton, mondayButton, tuesdayButton, wednesdayButton,
            thursdayButton, fridayButton, saturdaybutton, nil];



    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sundayTap:)];
    [sundayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mondayTap:)];
    [mondayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuesdayTap:)];
    [tuesdayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wednesdayTap:)];
    [wednesdayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thursdayTap:)];
    [thursdayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fridayTap:)];
    [fridayButton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saturdayTap:)];
    [saturdaybutton addGestureRecognizer:tapGesture];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sundayTap:)];
    [sundayButton addGestureRecognizer:tapGesture];
    tapGesture = nil;

    sundayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    mondayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    tuesdayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    wednesdayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    thursdayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    fridayButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];
    saturdaybutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unselected_day_button_color"]];

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
    [self selectDay:(weekday-1)];

    //alloc required vars
    self.dealData = [[NSMutableArray alloc] init];
    dealViewController = [[DealViewController alloc] init];

    //Show loading bar and reload the data
    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];
    [self reloadDataForInfo:[CalculationHelper convertIntToDay:(weekday-1)]];
}

-(void)initDayButtons
{
    for (NSUInteger i = 0; i < [dayButtons count]; i++)
    {

    }
}

//Implement this to select the current day once the user logs out/in
-(void)viewDidAppear:(BOOL)animated {

}
- (void)viewDidUnload
{
    //[self stopSpinner];
    [borderedSpinnerView.view removeFromSuperview];
    [self setDayControlBar:nil];
    [self setTable:nil];
    [self setSaturdaybutton:nil];
    [self setSundayButton:nil];
    [self setMondayButton:nil];
    [self setMondayButton:nil];
    [self setTuesdayButton:nil];
    [self setWednesdayButton:nil];
    [self setThursdayButton:nil];
    [self setFridayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.listData = nil;
    self.dealData = nil;
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

    dayControlBar.momentary = YES;

    [self reloadDataForInfo:@"Favorites"];

    /*
     NSArray* data = [[NSArray alloc] initWithObjects:@"poop", nil];
     [self connectToServer:data];
     */
    [dayControlBar setSelectedSegmentIndex:-1];
}

- (IBAction)dayButtonPressed:(id)sender
{
    //[self createAndDisplaySpinner];
    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];


    dayControlBar.momentary = NO;
    NSLog(@"Selected index:%i", [dayControlBar selectedSegmentIndex]);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"controlBarButtonPressed" object:self];

    [self reloadDataForInfo:[CalculationHelper convertIntToDay:[dayControlBar selectedSegmentIndex]]];

}

-(void) reloadDataForInfo:(NSString *)data
{
    //call server with day

    [self connectToServer:data];


    //if favorites:
    //still receive an array

}


-(IBAction)sundayTap:(id)sender
{
    if (!sundayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:0]];

        [sundayButton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [mondayButton setHighlighted:NO];
    }
}

-(IBAction)mondayTap:(id)sender {

    if (!mondayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:1]];

        //Set monday to highlight and set all others to no
        [mondayButton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}
-(IBAction)tuesdayTap:(id)sender {

    if (!tuesdayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:2]];
        [tuesdayButton setHighlighted:YES];
        [mondayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}
-(IBAction)wednesdayTap:(id)sender {

    if (!wednesdayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:3]];
        [wednesdayButton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [mondayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}
-(IBAction)thursdayTap:(id)sender {

    if (!thursdayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:4]];
        [thursdayButton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [mondayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}
-(IBAction)fridayTap:(id)sender {

    if (!fridayButton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:5]];
        [fridayButton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [mondayButton setHighlighted:NO];
        [saturdaybutton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}
-(IBAction)saturdayTap:(id)sender {

    if (!saturdaybutton.isHighlighted) {

        //show loading notification
        [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

        //fetch data
        [self reloadDataForInfo:[CalculationHelper convertIntToDay:6]];
        [saturdaybutton setHighlighted:YES];
        [tuesdayButton setHighlighted:NO];
        [wednesdayButton setHighlighted:NO];
        [thursdayButton setHighlighted:NO];
        [fridayButton setHighlighted:NO];
        [mondayButton setHighlighted:NO];
        [sundayButton setHighlighted:NO];
    }
}




-(void) selectDay:(int) day {

    switch (day) {
        case 0:
            [sundayButton setHighlighted:YES];
            break;
        case 1:
            [mondayButton setHighlighted:YES];
            break;
        case 2:
            [tuesdayButton setHighlighted:YES];
            break;
        case 3:
            [wednesdayButton setHighlighted:YES];
            break;
        case 4:
            [thursdayButton setHighlighted:YES];
            break;
        case 5:
            [fridayButton setHighlighted:YES];
            break;
        case 6:
            [saturdaybutton setHighlighted:YES];
            break;

        default:
            break;
    }
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

//Calculate number of rows
//called by table when it needs to draw one of its rows
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return[self.dealData count];
}

//Draws individual rows
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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



//specifes row selection
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




-(void)loadImageToCellWithString:(NSArray*)array {


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


-(void)refreshCellAtPosition:(NSNumber*)num {

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

-(void) createAndDisplaySpinner {

    if (spinner != nil) {
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
