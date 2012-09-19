//
//  AddCommentViewController.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController <UITextViewDelegate>
{
    UIToolbar *toolbar;
    IBOutlet UILabel *userName;
    IBOutlet UILabel *saysLabel;
}

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) NSString *uid;

- (IBAction)doneTapped:(id)sender;

@end
