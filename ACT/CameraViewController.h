//
//  CameraViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "config.h"
#import "NotesViewController.h"

@interface CameraViewController : UIViewController<UIAlertViewDelegate>
{
  //  UIImagePickerController *imagePickerController;
   // UIPopoverController *popoverController;
    UIImagePickerController *imagePicker;
    UIImage *newImage;
    UIImageView *bg;
    UITableView *tableview;
    UIImage *image;
    
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    UIImageView *image4;
    UIImageView *image5;
    UIAlertView *progressAlert;
    UIActivityIndicatorView *activityView;
    
}
-(UIImageView *)customview:(CGRect)frame setimage:(UIImage *)img;
-(void) callPicker;
- (void) didRotate:(NSNotification *)notification;

@end
