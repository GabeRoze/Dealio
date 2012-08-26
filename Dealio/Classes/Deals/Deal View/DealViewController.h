//
//  DealsViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMLParser;

@interface DealViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    BOOL userCommentPosted;
    UIActivityIndicatorView* spinner;

}


@property (assign, nonatomic) NSString* liked;
@property (assign, nonatomic) NSString* favorited;
@property (assign, nonatomic) NSString* commented;
@property (strong, nonatomic) NSArray* computers;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;
@property (strong, nonatomic) NSMutableDictionary* dealListData;
@property (strong, nonatomic) NSMutableDictionary* parserData;
@property (strong, nonatomic) NSMutableArray* comments;


- (IBAction)returnToDealsListView:(id)sender;


-(void) loadDealFromList:(NSDictionary*)data;

-(void)parseXMLFile:(NSData*)data;
-(void) stopSpinner;
-(void) createAndDisplaySpinner;
-(void) connectToServer:(NSArray*)data;


@end
