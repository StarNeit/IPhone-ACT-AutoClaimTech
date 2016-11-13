//
//  ReleaseViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarLeftViewController.h"
#import "HTTP.h"
#import "VINDB.h"

@interface ReleaseViewController : UIViewController
{
     UIPopoverController *popoverController;
    IBOutlet UIDatePicker *datepicker;
    UIActionSheet *actionSheet;
    UIButton *datebtn;
    UIButton *yearbtn;
    UITextField *custtxt;
    UITextField *protxt ;
    UILabel *techtxt;
    UITextField *add1txt;
    UITextField *add2txt;
    UITextField *scensetxt;
    UITextField *phonetxt;
     UITextField *citytxt;
     UITextField *statetxt;
     UITextField *zipcodetxt;
    UITableView *tableview;
    VINDB *updateVINDB;
    
}
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;
-(IBAction)changeText:(UITextField*)textfield;
-(NSString *) numberformat:(NSString *) num;
-(NSString *) formatIdentificationNumber:(NSString *)string;
@property(nonatomic,retain) NSString *zipcode;

@end
