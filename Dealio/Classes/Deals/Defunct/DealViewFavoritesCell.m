//
//  DealViewFavoritesCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewFavoritesCell.h"
#import "XMLParser.h"
#import "CalculationHelper.h"

@implementation DealViewFavoritesCell
@synthesize favoritesButton;
@synthesize spinnerView;
@synthesize parser;
@synthesize messageText;
@synthesize favorited;
@synthesize uid;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        messageText = @"No server connectivity";
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setFavoritedNo {
    favorited = NO;
    [favoritesButton setImage:[UIImage imageNamed:@"unlikedheart@2x.png"] forState:UIControlStateNormal];
}

-(void)setFavoritedYes {
    favorited = YES;
    [favoritesButton setImage:[UIImage imageNamed:@"likedheart@2x.png"] forState:UIControlStateNormal];
}


- (IBAction)favoritesButtonPressed:(id)sender {
    
    if (messageText == NULL) {

        messageText = @"No server connectivity";

    }
    /*
     
     from within here, we will connect to the server
     determine what will happen to the favorite button
     send a notification to show the (custom?) loading message
     then force an update
     
     
     
     
     WHEN UPDATE FAVE IN PROCESS
     SET MESSAGE TEXT TO UPDATING
     IF ATTEMPT TO UPDATE WHEN UPDATING IS SET
     TELL USER THEY CANT DO THAT RIGHT NOW OR JUST LET THE APP CHILL
     
     */
    
    //NSMutableArray* sendData = [NSMutableArray alloc];  
    NSString* sendData;
    
    NSLog(@"message text %@", messageText);
    NSLog(@"uid is %@", uid);
    
    if ([messageText isEqualToString:@"No server connectivity"]) {

        [self createAndDisplaySpinner];
        
        
        if (favorited == YES) {
            
            NSLog(@"favorited==YES");
            //[favoritesButton setImage:[UIImage imageNamed:@"unlikedheart@2x.png"] forState:UIControlStateNormal];
            //favorited = NO;

            //[sendData insertObject:@"no" atIndex:0];
            sendData = @"remove";
            [self connectToServer:sendData];
            
            //send notification to dealview that like has been removed
            
        }
        else {
            //[favoritesButton setImage:[UIImage imageNamed:@"likedheart@2x.png"] forState:UIControlStateNormal];
            //favorited = YES;
            sendData = @"add";
            [self connectToServer:sendData];
            
            
            //send notification to dealview that like has been added
        }
    }//end check for server connectivity
    else {
        
    }
}


-(void) createAndDisplaySpinner {

    self.favoritesButton.hidden = YES;

    CGFloat width = spinnerView.bounds.size.width;
    CGFloat height = spinnerView.bounds.size.height;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(width/2.0, height/2.0)];
    [self.spinnerView addSubview:spinner];
    [spinner startAnimating];
}

-(void) stopSpinner {
    
    
    self.favoritesButton.hidden = NO;
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    
}


-(void) connectToServer:(NSString*)data {
    
    messageText = @"server session";
    
    //attempt to connect to server
    NSString* functionURL = @"http://www.cinnux.com/user-func.php/";    
    NSString* urlAsString = @"";
    NSString* command1 = @"cmd=updatefav";
    urlAsString = [urlAsString stringByAppendingString:command1];
    NSString* command2 = [NSString stringWithFormat:@"&cmd2=%@",data];
    urlAsString = [urlAsString stringByAppendingString:command2];
    NSString* uidString = [NSString stringWithFormat:@"&uid=%@", self.uid ];
    urlAsString = [urlAsString stringByAppendingString:uidString];
    
    //urlAsString = [functionURL stringByAppendingString:urlAsString];
    
    NSLog(@"favorites url string: %@", urlAsString);
    
//    http://www.cinnux.com/user-func.php
    
   
    
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    
//    NSURL *url = [NSURL URLWithString:urlAsString];
    
    //NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //[urlRequest setTimeoutInterval:30.0f];
    //[urlRequest setHTTPMethod:@"GET"];
    
  //  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection 
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
         
         if ([data length] > 0 && error == nil) {
             NSString* html = [[NSString alloc] 
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
             
             NSLog (@"favorites html = %@", html);
             
             // parse file
             [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];
             
         }
         else if ([data length] == 0 && error == nil) {
             NSLog(@"Nothing was downloaded.");
             messageText = @"Server not responding";
             //[self stopSpinner];
             
             [self stopSpinner];
             
         }
         else if (error != nil) {
             NSLog(@"Error happened = %@", error);
             messageText = @"Error occured during login";
             //[self stopSpinner];
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

-(void) serverResponseAcquired {
 
    //perform changing of favorite button here if xml parsed good
    //else display user through notification
    
    //if parser is success
    
    [self stopSpinner];
    
    
    if (favorited == YES) {
        
        [favoritesButton setImage:[UIImage imageNamed:@"unlikedheart@2x.png"] forState:UIControlStateNormal];
        favorited = NO;
        messageText = @"No server connectivity";

        
        //send notification to dealview that like has been removed
        
    }
    else {
        [favoritesButton setImage:[UIImage imageNamed:@"likedheart@2x.png"] forState:UIControlStateNormal];
        favorited = YES;
        messageText = @"No server connectivity";

        
        //send notification to dealview that like has been added
    }

    
}




@end
