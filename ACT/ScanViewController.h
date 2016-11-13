//
//  ScanViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "Vehicle_releaseViewController.h"
#import "KeyViewController.h"
@interface ScanViewController : UIViewController <UIImagePickerControllerDelegate, ZBarReaderDelegate>
{
    
    UIImageView *resultImage;
    UITextView *resultText;
    IBOutlet UIButton *scannerBtn;
    IBOutlet UIView *keypad;
    IBOutlet UITextField *vintxt;
    IBOutlet UIButton *enterbtn;
    IBOutlet UIButton *gobtn;
    ZBarReaderViewController *reader;
    
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) IBOutlet UIView *keypad;
@property (nonatomic) NSUInteger supportedOrientationsMask;

- (IBAction) scanButtonTapped;

@end
