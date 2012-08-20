//
//  DealListViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FilterTableViewController.h"

@class DealViewController;
@class XMLParser;
@class BorderedSpinnerView;

@interface DealListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    UIViewController *filterTableViewController;

    UIActivityIndicatorView* spinner;

    BOOL filterViewDisplayed;
    BOOL firstLoadFinished;
}

@property (nonatomic, assign) int currentSelectedDay;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL FAVORITES_MODE;
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) NSMutableArray *dayButtons;
@property (strong, nonatomic) NSMutableArray *dayLabels;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;
@property (strong, nonatomic) NSMutableArray* dealData;
@property (strong, nonatomic) DealViewController* dealViewController;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *saturdaybutton;
@property (weak, nonatomic) IBOutlet UIImageView *sundayButton;
@property (weak, nonatomic) IBOutlet UIImageView *mondayButton;
@property (weak, nonatomic) IBOutlet UIImageView *tuesdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *wednesdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *thursdayButton;
@property (weak, nonatomic) IBOutlet UIImageView *fridayButton;
@property (weak, nonatomic) IBOutlet UIImageView *filterButton;
@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;

-(void) favoritesButtonPressed:(NSNotification*) notification;
-(void) reloadDataForInfo:(NSString*)data;
-(void)parseXMLFile:(NSData*)data;
-(void) connectToServer:(NSString*)data;
-(void)filterButtonTapped;
+(DealListViewController *)instance;

@end
