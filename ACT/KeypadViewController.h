//
//  KeypadViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTP.h"

@interface KeypadViewController : UIViewController
{
    IBOutlet UIView *keypad;
    IBOutlet UITextField *vintxt;
    IBOutlet UIButton *enterbtn;
    IBOutlet UIButton *gobtn;
    IBOutlet UIButton *gobtn1;
    IBOutlet UIImageView *keyimage;
}
- (void) callWebService;

@end
