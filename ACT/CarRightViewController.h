//
//  CarRightViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signview.h"
#import "NotesViewController.h"

@interface CarRightViewController : UIViewController
{
    signview *carsign;
    UIImageView *bg;
    UISwipeGestureRecognizer *leftRecognizer;
    UISwipeGestureRecognizer *rightRecognizer;
    UIView *carrightimage;
    UIButton *clearbtn;
}

@end
