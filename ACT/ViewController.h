//
//  ViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Over_ViewController.h"
#import "HTTP.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "VINDB.h"
#import "SaveData.h"
@interface ViewController : UIViewController
{
    UITextField *pinnumber;
    UIProgressView *progressView;
    UIActivityIndicatorView  *activityView ;
    UIAlertView *progressAlert;
}
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;
- (void) callWebService;
-(BOOL) checkIsSave;
@end
