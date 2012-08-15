//
//  DealsViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewController.h"
#import "TheRestaurantAppDelegate.h"
#import "DealViewCell.h"
#import "DealViewLogoCell.h"
#import "DealViewInfoCell.h"
#import "DealViewPhoneCell.h"
#import "DealViewMapInfoCell.h"
#import "DealViewUrlCell.h"
#import "DealViewResizableCell.h"
#import "DealViewLikeCell.h"
#import "DealViewFavoritesCell.h"
#import "DealViewCommentHeaderCell.h"
#import "DealViewCommentCell.h"
#import "DealViewRemoveCommentCell.h"
#import "XMLParser.h"
#import "CalculationHelper.h"
#import "DealViewRestaurantInfoCell.h"



@implementation DealViewController

@synthesize table;
@synthesize comments;

@synthesize backButton;
@synthesize computers;
@synthesize description;


@synthesize dealListData;
@synthesize messageText;
@synthesize parser;
@synthesize parserData;

@synthesize liked;
@synthesize commented;
@synthesize favorited;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        UILabel* label = [CalculationHelper createNavBarLabelWithTitle:@"Deals"];
        [self.view addSubview:label];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)loadDealFromList:(NSDictionary *)data
{
    self.dealListData = [NSMutableDictionary dictionaryWithDictionary:data];
    NSLog(@"dela list data %@", dealListData);
    [self connectToServer:[dealListData objectForKey:@"uid"]];
    [table reloadData];
    [self createAndDisplaySpinner];
}



#pragma mark -
#pragma mark - View lifecycle

/*
-(void)viewDidDisappear:(BOOL)animated {

    NSLog(@"view will appear");
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    [indexSet addIndex:2];
    [indexSet addIndex:4];


    [table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.table setSeparatorColor:[UIColor clearColor]];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(favoriteRemoved:)
                                                 name:@"favoriteRemoved"
                                               object:nil];
}




- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.computers = nil;
    self.comments = nil;
    //NSLog(@"VIEW UNLOADED!");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)returnToDealsListView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    //release this instance (may not be needed due to ARC
    //[self viewDidUnload];
}

#pragma mark -
#pragma mark Sever Connection and XML



-(void) connectToServer:(NSString*)data
{
    //attempt to connect to server

    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newdealdetail-func.php";

    // NSString* emailString = [NSString stringWithFormat:@"?useremail=%@",(NSString*)[userData objectAtIndex:0] ];
    // NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
    NSString* phpData = [NSString stringWithFormat:@"uid=%@",data ];


    /*
    urlAsString = [urlAsString stringByAppendingString:phpData];
    // urlAsString = [urlAsString stringByAppendingString:passwordString];

    NSLog(@"urlstr: %@", urlAsString);

    NSURL *url = [NSURL URLWithString:urlAsString];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    */

    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:phpData];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

         if ([data length] > 0 && error == nil) {
             NSString* html = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];

             NSLog (@"Deal Info HTML = %@", html);

             // parse file
             [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];

         }
         else if ([data length] == 0 && error == nil) {
             NSLog(@"Nothing was downloaded.");
             messageText = @"Server not responding";
             [self stopSpinner];
         }
         else if (error != nil) {
             NSLog(@"Error happened = %@", error);
             messageText = @"Error occured during login";
             [self stopSpinner];
         }
     }];




    // [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];

}


-(void) parseXMLFile:(NSData*)data {
    parser = [[XMLParser alloc] initXMLParser:data];
    //[self performSelectorOnMainThread:@selector(stopSpinner) withObject:nil waitUntilDone:YES];


    //messageText = [parser.loginResult objectForKey:@"loginResult"];
    [self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];


}


-(void) resizeDescription {

    NSLog(@"reize happened");

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:2];
    [table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

}



-(void) reloadTableData {

    [table reloadData];
    [self performSelectorOnMainThread:@selector(resizeDescription) withObject:nil waitUntilDone:YES];

}
-(void) serverResponseAcquired
{
    NSLog(@"parser.dealitem: %@", parser.dealItem);

    parserData = [NSMutableDictionary dictionaryWithDictionary:parser.dealItem];
    //comments = [NSMutableArray arrayWithArray:parser.dealComments];
    NSLog(@"comments: %@", parser.dealComments);
    comments = parser.dealComments;

    [table reloadData];

    [self performSelector:@selector(resizeDescription) withObject:nil afterDelay:0.1];


    // stop spinner
    [self stopSpinner];
}



#pragma mark -
#pragma mark Spinner

-(void) createAndDisplaySpinner
{
    if (spinner != nil)
    {
        [self stopSpinner];
    }

    // NSLog(@"spiner displayed");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height = [UIScreen mainScreen].bounds.size.height;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(width-25.0 ,20.0)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    //[self.view setNeedsDisplay];
}

-(void) stopSpinner
{
    //NSLog(@"spinner hidden");

    [spinner stopAnimating];
    [spinner removeFromSuperview];

}




#pragma mark -
#pragma mark Table Data Source Method
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;


        case 1:

            return 1;
            break;


        case 2:
            return 1;
            break;

        case 3:
            return 2;
            break;

        case 4:
            return comments.count+1;
            break;

        case 5:
            return 1;


        default:
            break;
    }

    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Logo and info cells
    static NSString* CellTableIdentifier1 = @"CellTableIdentifier1";
    static NSString* CellTableIdentifier2 = @"CellTableIdentifier2";

    //Phone, Address, and Website cells
    static NSString* CellTableIdentifier3 = @"CellTableIdentifier3";
    static NSString* CellTableIdentifier4 = @"CellTableIdentifier4";
    static NSString* CellTableIdentifier5 = @"CellTableIdentifier5";

    //Description cell
    static NSString* CellTableIdentifier6 = @"CellTableIdentifier6";

    //Fave and Like cells
    static NSString* LikeCell = @"DealViewLikeCell";
    static NSString* FavoritesCell = @"DealViewFavoritesCell";

    // comment cells
    static NSString* CommentHeaderCell = @"DealViewCommentHeaderCell";
    static NSString* CommentCell = @"DealViewCommentCell";
    static NSString* RemoveCommentCell = @"DealViewRemoveCommentCell";

    // Restaurant Info Cell (new)
    static NSString* DealInfoCell = @"DealViewRestaurantInfoCell";

    static BOOL nibsRegistered = NO;

    UITableViewCell* cell;

    if (!nibsRegistered)
    {
        UINib* nib1 = [UINib nibWithNibName:@"DealViewLogoCell" bundle:nil];
        UINib* nib2 = [UINib nibWithNibName:@"DealViewInfoCell" bundle:nil];
        UINib* nib3 = [UINib nibWithNibName:@"DealViewPhoneCell" bundle:nil];
        UINib* nib4 = [UINib nibWithNibName:@"DealViewMapInfoCell" bundle:nil];
        UINib* nib5 = [UINib nibWithNibName:@"DealViewUrlCell" bundle:nil];
        UINib* nib6 = [UINib nibWithNibName:@"DealViewResizableCell" bundle:nil];

        //Like and fave cells
        UINib* likeCellNib = [UINib nibWithNibName:@"DealViewLikeCell" bundle:nil];
        UINib* favoritesCellNib = [UINib nibWithNibName:@"DealViewFavoritesCell" bundle:nil];

        //comment cells
        UINib* commentHeaderNib = [UINib nibWithNibName:@"DealViewCommentHeaderCell" bundle:nil];
        UINib* commentCelllNib = [UINib nibWithNibName:@"DealViewCommentCell" bundle:nil];
        UINib* removeCommentCellNib = [UINib nibWithNibName:@"DealViewRemoveCommentCell" bundle:nil];

        //New deal info cell
        UINib* restaurantInfoCellNib = [UINib nibWithNibName:@"DealViewRestaurantInfoCell" bundle:nil];

        //header cells
        [tableView registerNib:nib1 forCellReuseIdentifier:CellTableIdentifier1];
        [tableView registerNib:nib2 forCellReuseIdentifier:CellTableIdentifier2];

        //call, addr, map cells
        [tableView registerNib:nib3 forCellReuseIdentifier:CellTableIdentifier3];
        [tableView registerNib:nib4 forCellReuseIdentifier:CellTableIdentifier4];
        [tableView registerNib:nib5 forCellReuseIdentifier:CellTableIdentifier5];

        //description cell
        [tableView registerNib:nib6 forCellReuseIdentifier:CellTableIdentifier6];

        //like and fave cells
        [tableView registerNib:likeCellNib forCellReuseIdentifier:LikeCell];
        [tableView registerNib:favoritesCellNib forCellReuseIdentifier:FavoritesCell];

        //comment cells
        [tableView registerNib:commentHeaderNib forCellReuseIdentifier:CommentHeaderCell];
        [tableView registerNib:commentCelllNib forCellReuseIdentifier:CommentCell];
        [tableView registerNib:removeCommentCellNib forCellReuseIdentifier:RemoveCommentCell];

        //New deal info cell
        [tableView registerNib:restaurantInfoCellNib forCellReuseIdentifier:DealInfoCell];

        nibsRegistered = YES;
    }

    switch (indexPath.section)
    {
        case 0:
            //Header cell
            if (indexPath.row == 0) {
                DealViewLogoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier1"];

                if (!cell1) {
                    cell = [[DealViewLogoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier1"];

                }
                else {
                    cell1.backgroundColor = [UIColor clearColor];
                    cell1.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];

                    //   cell1.restaurantName = @"McDonalds";


                    cell1.restaurantName = [dealListData objectForKey:@"businessname"];

                    //  cell1.dealName = @"Free Burgers!";
                    cell1.dealName = (NSString*)[dealListData objectForKey:@"dealname"];
                    //  cell1.restaurantLogoImageView.image = [UIImage imageNamed:@"mcdonalds_logo.png"];


                    /*
                    NSString* imageUrlString = [NSString stringWithFormat:@"http://www.cinnux.com/logos/%@", [dealListData objectForKey:@"logoname"]];

                    NSURL *url = [NSURL URLWithString:imageUrlString];
                    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
                    cell1.restaurantLogoImageView.image = image; */

                    [cell1 setLogoWithString:(NSString*)[dealListData objectForKey:@"logoname"]];




                    cell = cell1;

                }
            }

            //info cell
            else if (indexPath.row == 1) {
                DealViewInfoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier2"];

                if (!cell1) {
                    cell = [[DealViewInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier2"];

                }
                else {


//                    NSString* dealRating = [CalculationHelper convertLikesToRating:[dealListData objectForKey:@"numlikes"] dislikes: [dealListData objectForKey:@"dislike"]];
                    NSString *dealRating = [dealListData objectForKey:@"numlikes"];
                    NSString* dealTime = [CalculationHelper convert24HourTimesToString:[dealListData objectForKey:@"starttime"] endTime:[dealListData objectForKey:@"endtime"]];

                    cell1.rating = dealRating;
                    cell1.dealTime = dealTime;
                    //     cell1.dealDays = @"M/W/F";
                    cell1.backgroundImage.image = [UIImage imageNamed:@"info_background.png"];
                    cell = cell1;
                }
            }
            break;

        case 1:

            //Restaurant Info
            if (indexPath.row == 0)
            {
                DealViewRestaurantInfoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewRestaurantInfoCell"];
                if (!cell1)
                {
                    cell = [[DealViewRestaurantInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewRestaurantInfoCell"];
                }
                else
                {
                    [cell1 setStreetAddress:[parserData objectForKey:@"storeaddress"]];
                    [cell1 setCityAddress: [parserData objectForKey:@"storecity"] withState:[parserData objectForKey:@"storestate"]];
                    [cell1 setUrl:[parserData objectForKey:@"businesswebaddress"]];
                    [cell1 setPhone:[parserData objectForKey:@"storenumber"]];
                    cell = cell1;
                }

                /*
                DealViewPhoneCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier3"];

                if (!cell1) {
                    cell = [[DealViewPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier3"];

                }
                else {

                    cell1.phone = [parserData objectForKey:@"storenumber"];

                    //           cell1.phone = @"226-220-8750";
                    cell = cell1;
                }
                */
            }

            //address
            else if (indexPath.row == 1) {
                DealViewMapInfoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier4"];

                if (!cell1) {
                    cell = [[DealViewMapInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier4"];

                }
                else {
                    //   cell1.streetAddress = @"545 Belmont Ave West Apt 507";
                    cell1.streetAddress = [parserData objectForKey:@"storeaddress"];
                    cell1.cityAddress = [parserData objectForKey:@"storecity"];

                    //   cell1.cityAddress = @"Kitchener";
                    cell = cell1;

                }
            }

            //website
            else if (indexPath.row == 2) {
                DealViewUrlCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier5"];

                if (!cell1) {
                    cell = [[DealViewUrlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier5"];

                }
                else {
                    //    cell1.url = @"http://www.gaberoze.com";

                    cell1.url = [parserData objectForKey:@"businesswebaddress"];
                    cell = cell1;

                    NSLog(@"website: %@", [parserData objectForKey:@"businesswebaddress"]);


                }
            }


            break;

        case 2:

            //description
            if (indexPath.row == 0) {

                DealViewResizableCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CellTableIdentifier6"];

                if (!cell1) {
                    cell = [[DealViewResizableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableIdentifier6"];
                }
                else {

                    if (parserData != nil)
                    {

                        //[cell1 setCellHeight:@""];
                        description = [parserData objectForKey:@"detail"];
                    }
                   // else {
                   //     description = @"No description available";
                   // }

                    [cell1 setCellHeight:description];
                    cell = cell1;

                    /*
                    //[tableView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationFade];
                    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
                    [indexSet addIndex:2];
                    [table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                    */

                    //[self performSelectorOnMainThread:@selector(resizeDescription) withObject:nil waitUntilDone:YES];



                }

            }
            break;



        case 3:

            //like button
            if (indexPath.row == 0) {
                DealViewLikeCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewLikeCell"];

                if (!cell1) {
                    cell = [[DealViewLikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewLikeCell"];
                }
                else {
                    // USE LIKED STATUS TO DETERMINE STATUS OF THIS CELL


                    liked = [parserData objectForKey:@"userliked"];
                    //like
                    //dislike
                    //none

                    if ([liked isEqualToString:@"like"]) {
                        [cell1 setLikedYes];
                    }
                    else if ([liked isEqualToString:@"dislike"]) {
                        [cell1 setLikedNo];
                    }
                    else if ([liked isEqualToString:@"none"]) {
                        //set liked to none
                    }


                    //[cell1 setLikedNo];

                    cell = cell1;
                }

            }

            //favorites button
            if (indexPath.row == 1) {
                DealViewFavoritesCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewFavoritesCell"];

                if (!cell1) {
                    cell = [[DealViewFavoritesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewFavoritesCell"];
                }
                else {
                    // USE LIKED STATUS TO DETERMINE STATUS OF THIS CELL

                    //[cell1 setFavoritedNo];

                    favorited = [parserData objectForKey:@"userfavorited"];


                    if ([favorited isEqualToString:@"yes"]) {
                        [cell1 setFavoritedYes];
                    }
                    else if ([favorited isEqualToString:@"no"]) {
                        [cell1 setFavoritedNo];
                    }
                    cell1.uid = [dealListData objectForKey:@"uid"];

                    cell = cell1;
                }

            }




            break;

        case 4:

            //comment header
            if (indexPath.row == 0) {


                NSString* count = [NSString stringWithFormat:@"%i", comments.count];

                DealViewCommentHeaderCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewCommentHeaderCell"];

                if (!cell1) {
                    cell = [[DealViewCommentHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewCommentHeaderCell"];
                }
                else {

                    [cell1 setNumberComments:count];
                    cell = cell1;
                }
            }


            //comments
            else if (indexPath.row > 0)
            {

                int row = indexPath.row;

                DealViewCommentCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewCommentCell"];



                /*
                 if (!cell1) {
                 cell = [[DealViewCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewCommentCell"];
                 }

                 else {
                 NSDictionary* commentDict = [comments objectAtIndex:row-1];
                 NSString* stringData = [commentDict objectForKey:@"Comment"];
                 [cell1 setCellHeight:stringData];
                 [cell1 setCommentText:stringData];
                 cell = cell1;
                 }
                 */
                //NSLog (@"the cell index is %i", indexPath.row);


            //    NSDictionary* commentDict = [comments objectAtIndex:row-1];
             //   NSString* stringData = [commentDict objectForKey:@"Comment"];

                NSString* comment = [comments objectAtIndex:row-1];

                [cell1 setCellHeight:comment];
                [cell1 setCommentText:comment];
                cell = cell1;

            }

            break;

        case 5:

            //add/remove comment
            if (indexPath.row == 0)// && userCommentPosted == YES)
            {


                DealViewRemoveCommentCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DealViewRemoveCommentCell"];

                if (!cell1) {
                    cell = [[DealViewRemoveCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealViewRemoveCommentCell"];
                }
                else {

                    //add logic to add/remove comments here
                    cell = cell1;
                }

            }
        default:
            break;
    }



    return cell;
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            if (indexPath.row == 0)
            {
                return 100;
            }
            else if (indexPath.row == 1)
            {
                return 25;
            }
            else {
                return 65;
            }
            break;

        case 1:
            if (indexPath.row == 0)
            {
                //restaurant info cell
                return 150;
            }
            else if (indexPath.row == 1)
            {
                return 60;
            }
            else if (indexPath.row == 2)
            {
                return 44;
            }

            else {
                return 65;
            }
            break;

        case 2:
            if (indexPath.row == 0)
            {
                return [DealViewResizableCell getCellHeight:description];
            }
            break;

        case 3:
            if (indexPath.row == 0)
            {
                return 44;
            }

            else if (indexPath.row == 1){
                return 44;
            }
            break;

        case 4:
            if (indexPath.row == 0)
            {
                return 30;
            }

            else if (indexPath.row > 0)
            {
                //NSDictionary* commentDict = [comments objectAtIndex:indexPath.row - 1];
                //NSString* curComment = [commentDict objectForKey:@"Comment"];
                NSString* curComment = [comments objectAtIndex:indexPath.row-1];

                return [DealViewCommentCell getCellHeight:curComment];
            }
            break;

        case 5:
            if (indexPath.row == 0) {
                return 44;
            }

        default:
            break;
    }
    return 0;
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

    //NSUInteger row = [indexPath row];


    /*
     switch (indexPath.section) {
     case 0:
     if(indexPath.row == 1)
     break;

     default:
     break;


     return indexPath;
     */

    return indexPath;
}

























@end
