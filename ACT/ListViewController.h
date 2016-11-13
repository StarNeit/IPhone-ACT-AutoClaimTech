//
//  ListViewController.h
//  ACT
//
//  Created by Innoppl Technologies on 01/08/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"


@interface ListViewController : UIViewController
{
    UITextField *text1;
    UITableView *tableview;
    UILabel *vin;
    UIButton *chkbtn1;
    ZBarReaderViewController *reader;
    UIImageView *resultImage;
    UITextView *resultText;
    UIButton *submitbtn;
    UIButton *deletebtn;
    UIButton *remove;
    
}
@property(nonatomic,retain) NSString *vinnumber;
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;
- (void) callWebService;
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
-(void)submit;
-(void) didSubmit:(NSString*)status statusCode:(int)code;
-(void)deleteRow:(UIButton*)btn;
-(void) pdfpage;
-(void) isEmpty;





@end
