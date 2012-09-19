//
//  AddCommentViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "AddCommentViewController.h"
#import "DealioService.h"
#import "XMLParser.h"
#import "DealListViewCell.h"
#import "GRCustomSpinnerView.h"
#import "Models.h"

@implementation AddCommentViewController

@synthesize commentTextView;
@synthesize doneButton;
@synthesize uid;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadToolbar];

    userName.text = [NSString stringWithFormat:@"%@ %@", UserData.instance.firstName, UserData.instance.lastName];
    [userName sizeToFit];

    CGRect frame = userName.frame;
    frame.origin.x = 10;
    frame.origin.y = 5;
    userName.frame = frame;

    frame = CGRectMake(userName.frame.size.width + 12, userName.frame.origin.y, 30, userName.frame.size.height);
    saysLabel.frame = frame;

    [commentTextView becomeFirstResponder];
}

-(void)loadToolbar
{
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"KeyboardToolBar" owner:self options:nil];
    toolbar = (UIToolbar*)[nib objectAtIndex:0];
}

- (IBAction)doneTapped:(id)sender
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    if (commentTextView.text.length < 1 || [[commentTextView.text stringByTrimmingCharactersInSet:set] length] == 0)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [DealioService submitComment:commentTextView.text uid:uid onSuccess:^(NSData *data)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
            {
                XMLParser *parser = [[XMLParser alloc] initXMLParser:data];

                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if ([[parser.userFunction objectForKey:@"message"] isEqualToString:@"fail"])
                    {
                        [DealioService webConnectionFailed];
                    }
                    [self dismissModalViewControllerAnimated:YES];
                });
            });

        } onFailure:nil];
    }
}

#pragma mark - UITextView Delegate
-(void)textViewDidChange:(UITextView *)textView
{
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.inputAccessoryView = toolbar;
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
}


@end
