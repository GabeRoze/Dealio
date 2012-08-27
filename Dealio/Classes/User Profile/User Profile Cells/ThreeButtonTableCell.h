//
//  ThreeButtonTableCell.h
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ThreeButtonTableCell : UITableViewCell <MFMailComposeViewControllerDelegate>
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *passwordButtonImageView;
    IBOutlet UIImageView *feedbackButtonImageView;
    IBOutlet UIImageView *bugReportButtonImageView;
}

@end
