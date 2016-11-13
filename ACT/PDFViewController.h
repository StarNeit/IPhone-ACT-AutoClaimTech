//
//  PDFViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTP.h"
#import "ASIFormDataRequest.h"
#import "CreatePDF.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class UIPrintInteractionController;

@interface PDFViewController : UIViewController
{
    UIWebView *web;
    UIButton *printButton;
    UIButton *printbtn;
    UIPrintInteractionController *printController;
    UIAlertView *progressAlert;
    UIActivityIndicatorView *activityView;
    UIButton *signbtn;
    UIButton *submitbtn;
    UIButton *sharebtn;
    UIButton *savebtn;
    BOOL isprint;
    CreatePDF *pdf;

}
-(void) alertview:(NSString*)str;
- (void)setupPrintButton;
- (void)printTapped;
- (NSData *)generatePDFDataForPrinting;
- (void)createPDFFile;
- (void)loadPDFFile;

-(void) saveJsonData;

@end
