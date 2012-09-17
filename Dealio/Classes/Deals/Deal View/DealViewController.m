//
//  DealsViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewController.h"
#import "TheRestaurantAppDelegate.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "DealViewDetailCell.h"
#import "TableFooterCell.h"
#import "ContactInfoCell.h"
#import "MapViewCell.h"
#import "DealioService.h"
#import "DealioMapAnnotation.h"
#import "DealViewDescriptionCell.h"
#import "ImageCache.h"
#import "GRCustomSpinnerView.h"
#import "DealioService.h"
#import "Models.h"
#import "CommentHeaderViewCell.h"

@implementation DealViewController

@synthesize table;
@synthesize comments;
@synthesize dealListData;
@synthesize parser;
@synthesize parserData;

#pragma mark -
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    topBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    bottomBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    distanceLabel.text = [CalculationHelper formatDistance:[dealListData objectForKey:@"distance"]];
    dealNameLabel.text = [dealListData objectForKey:@"businessname"];
    dealImageView.image = [ImageCache.sharedImageCache getImage:[dealListData objectForKey:@"logoname"]];
    distanceLabel.font = [UIFont fontWithName:@"Rokkitt-bold" size:distanceLabel.font.pointSize];
    dealNameLabel.font = [UIFont fontWithName:@"Rokkitt" size:dealNameLabel.font.pointSize];

    [GRCustomSpinnerView.instance addSpinnerToView:self.view];
    [self loadDealFromList:nil];
}

-(void)loadDealFromList:(NSDictionary *)dealDictionary
{
    [DealioService getDealWithUID:[dealListData objectForKey:@"uid"] onSuccess:^(NSData *data){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            parser = [[XMLParser alloc] initXMLParser:data];

            NSLog(@"comments %@", parser.dealComments);

            dispatch_async( dispatch_get_main_queue(), ^{
                viewJustLoaded = YES;
                parserData = [NSMutableDictionary dictionaryWithDictionary:parser.dealItem];
                comments = parser.dealComments;
                [table reloadData];
                [GRCustomSpinnerView.instance stopSpinner];
            });
        });

    } onFailure:nil];
}

#pragma mark -
#pragma mark Table Data Source Method
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    if (indexPath.row == 0)
    {
        CellIdentifier = @"DealViewDetailCellIdentifier";

        DealViewDetailCell *dealViewDetailCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!dealViewDetailCell)
        {
            dealViewDetailCell = [DealViewDetailCell new];
        }

        dealViewDetailCell.uid = [dealListData objectForKey:@"uid"];

        if (viewJustLoaded)
        {
            [dealViewDetailCell loadInitialValuesWithFavorited:[parserData objectForKey:@"userfavorited"] liked:[parserData objectForKey:@"userliked"] numLikes:[dealListData objectForKey:@"numlikes"]];
            dealViewDetailCell.dealNameLabel.text = [dealListData objectForKey:@"dealname"];
        }

        return dealViewDetailCell;
    }
    else if (indexPath.row == 1)
    {
        CellIdentifier = @"TableFooterCellIdentifier";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_tan_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 2)
    {
        CellIdentifier = @"ContactInfoCellIdentifier";

        ContactInfoCell *contactInfoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!contactInfoCell)
        {
            contactInfoCell = [ContactInfoCell new];
        }

        contactInfoCell.leftImageView.image = [UIImage imageNamed:@"button_phonenumber.png"];
        contactInfoCell.contactType = phone;
        contactInfoCell.contactLabel.text =  [parserData objectForKey:@"storenumber"];

        return contactInfoCell;
    }
    else if (indexPath.row == 3)
    {
        CellIdentifier = @"ContactInfoCellIdentifier";

        ContactInfoCell *contactInfoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!contactInfoCell)
        {
            contactInfoCell = [ContactInfoCell new];
        }

        contactInfoCell.leftImageView.image = [UIImage imageNamed:@"button_webaddress.png"];
        contactInfoCell.contactType = website;
        contactInfoCell.contactLabel.text =  [parserData objectForKey:@"businesswebaddress"];

        return contactInfoCell;
    }
    else if (indexPath.row == 4)
    {
        CellIdentifier = @"ContactInfoCellIdentifier";

        ContactInfoCell *contactInfoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!contactInfoCell)
        {
            contactInfoCell = [ContactInfoCell new];
        }

        contactInfoCell.leftImageView.image = [UIImage imageNamed:@"button_map.png"];
        contactInfoCell.contactType = address;
        contactInfoCell.contactLabel.text =  [parserData objectForKey:@"storeaddress"];
        contactInfoCell.longitude = [dealListData objectForKey:@"longitude"];
        contactInfoCell.latitude = [dealListData objectForKey:@"latitude"];

        return contactInfoCell;
    }
    else if (indexPath.row == 5)
    {
        CellIdentifier = @"MapViewCellIdentifier";

        MapViewCell *mapViewCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!mapViewCell)
        {
            mapViewCell = [MapViewCell new];
        }

        CLLocationCoordinate2D annotationCoord;

        annotationCoord.latitude = [[dealListData objectForKey:@"latitude"] floatValue];
        annotationCoord.longitude = [[dealListData objectForKey:@"longitude"] floatValue];

        [mapViewCell.mapView removeAnnotations:mapViewCell.mapView.annotations];

        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [dealListData objectForKey:@"dealname"];
        annotationPoint.subtitle = [dealListData objectForKey:@"businessname"];
        [mapViewCell.mapView addAnnotation:annotationPoint];

        MKCoordinateRegion zoomIn = mapViewCell.mapView.region;
        zoomIn.span.latitudeDelta = 0.01;
        zoomIn.span.longitudeDelta = 0.01;
        zoomIn.center.latitude = [[dealListData objectForKey:@"latitude"] floatValue];
        zoomIn.center.longitude = [[dealListData objectForKey:@"longitude"] floatValue];
        [mapViewCell.mapView setRegion:zoomIn animated:YES];
        [self performSelector:@selector(selectLastAnnotation:) withObject:mapViewCell.mapView afterDelay:1.0f];

        return mapViewCell;
    }
    else if (indexPath.row == 6)
    {
        CellIdentifier = @"DealViewDescriptionCellIdentifier";

        DealViewDescriptionCell *dealViewDescriptionCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!dealViewDescriptionCell)
        {
            dealViewDescriptionCell = [DealViewDescriptionCell new];
        }

        dealViewDescriptionCell.descriptionTextView.text = [parserData objectForKey:@"description"];

        CGRect newFrame = dealViewDescriptionCell.backgroundImage.frame;
        newFrame.size.height = [CalculationHelper calculateCellHeightWithString:[parserData objectForKey:@"description"] forWidth:300]+30;
        dealViewDescriptionCell.backgroundImage.frame = newFrame;

        newFrame = dealViewDescriptionCell.descriptionTextView.frame;
        newFrame.size.height = [CalculationHelper calculateCellHeightWithString:[parserData objectForKey:@"description"] forWidth:300];
        dealViewDescriptionCell.descriptionTextView.frame = newFrame;

        dealViewDescriptionCell.backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];

        return dealViewDescriptionCell;
    }
    else if (indexPath.row == 7)
    {
        CellIdentifier = @"TableFooterCellIdentifier";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_teal_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 8)
    {
        CellIdentifier = @"CommentHeaderViewCellIdentifier";

        CommentHeaderViewCell *commentHeaderViewCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!commentHeaderViewCell)
        {
            commentHeaderViewCell = [CommentHeaderViewCell new];
        }
        return commentHeaderViewCell;
    }
    else if (indexPath.row >= 9 && commentsVisible)
    {

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 120;
    }
    else if (indexPath.row == 1 || indexPath.row == 7)
    {
        return 20;
    }
    else if (indexPath.row >= 2 && indexPath.row <= 4)
    {
        return 44;
    }
    else if (indexPath.row == 5)
    {
        return 240;
    }
    else if (indexPath.row == 6)
    {
        return [CalculationHelper calculateCellHeightWithString:[parserData objectForKey:@"description"] forWidth:300]+30;
    }
    else if (indexPath.row == 8)
    {
        return 40;
    }
}

-(void)selectLastAnnotation:(MKMapView *)mapView
{
    if (viewJustLoaded)
    {
        [mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:YES];
        viewJustLoaded = NO;
    }
}

- (IBAction)backTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
