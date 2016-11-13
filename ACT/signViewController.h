//
//  signViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signview.h"
#import "VINDB.h"

@interface signViewController : UIViewController
{
    signview *signimage;
    UIButton *signbtn;
    UIButton *datebtn;
    UIPopoverController *popoverController;
    IBOutlet UIDatePicker *datepicker1;
    UIButton *okbtn;
    VINDB *updateVINDB;

}

@end
