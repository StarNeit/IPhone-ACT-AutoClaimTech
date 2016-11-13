//
//  signatureViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signview.h"
#import "CarLeftViewController.h"
#import "VINDB.h"

@interface signatureViewController : UIViewController
{
     signview *sign1;
    signview *sign2;
    UIButton *datebtn1;
    UIButton *datebtn2;
    UIPopoverController *popoverController;
    IBOutlet UIDatePicker *datepicker1;
    IBOutlet UIDatePicker *datepicker2;
    UIActionSheet *actionSheet;
    UIButton *sign1btn;
    UIButton *sign2btn;
    VINDB *updateVINDB;
    UIButton *savebtn;
    
}

@end
