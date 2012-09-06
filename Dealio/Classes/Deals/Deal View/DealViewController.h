//
//  DealsViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class XMLParser;

@interface DealViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>
{
    BOOL userCommentPosted;
    UIActivityIndicatorView* spinner;

    IBOutlet UILabel *dealNameLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UIImageView *dealImageView;

    IBOutlet UIImageView *topBackgroundImage;
    IBOutlet UIImageView *bottomBackgroundImage;}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) XMLParser* parser;
@property (strong, nonatomic) NSMutableDictionary* dealListData;
@property (strong, nonatomic) NSMutableDictionary* parserData;
@property (strong, nonatomic) NSMutableArray* comments;

-(void) loadDealFromList:(NSDictionary*)dealDictionary;
//-(void)parseXMLFile:(NSData*)data;
//-(void) stopSpinner;
//-(void) createAndDisplaySpinner;
//-(void) connectToServer:(NSString*)data;
- (IBAction)backTapped:(id)sender;

@end
