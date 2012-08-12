//
//  DealListViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class DealViewController;
@class XMLParser;
@class BorderedSpinnerView;

@interface DealListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    UIActivityIndicatorView* spinner;

}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (assign, nonatomic) BOOL FAVORITES_MODE;
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) IBOutlet UISegmentedControl *dayControlBar;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;
@property (strong, nonatomic) NSMutableArray* dealData;
@property (strong, nonatomic) DealViewController* dealViewController;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;
@property (strong, nonatomic) CLLocation* currentLocation;

@property (weak, nonatomic) IBOutlet UIImageView *saturdaybutton;
@property (weak, nonatomic) IBOutlet UIImageView *sundayButton;
@property (weak, nonatomic) IBOutlet UIImageView *mondayButton;
@property (weak, nonatomic) IBOutlet UIImageView *tuesdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *wednesdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *thursdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *fridayButton;




-(void) favoritesButtonPressed:(NSNotification*) notification;
- (IBAction)dayButtonPressed:(id)sender;


-(void) reloadDataForInfo:(NSString*)data;
-(void)refreshCellAtPosition:(NSNumber*)num;


-(void)parseXMLFile:(NSData*)data;
-(void) stopSpinner;
-(void) createAndDisplaySpinner;
-(void) connectToServer:(NSString*)data;
-(void)loadImageToCellWithString:(NSArray*)array; 
-(void)selectDay:(int)day;


@end
