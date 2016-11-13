//
//  Vehicle_releaseViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 02/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VINDB.h"

@interface Vehicle_releaseViewController : UIViewController
{
    UIButton *yearbtn;
    UIButton *windbtn;
    UIPickerView *pickerview;
    UIActionSheet *actionsheet;
    UIPopoverController *popoverController;
    UITextField *modeltxt;
    UITextField *maketxt;
    UITextField *colortxt;
    UITextField *mileagetxt;
    UILabel *claimtxt;
    UITextField *materialtxt;
    UITableView *tableview;
    UITextField *yeartext;
     UITextField *zipCode;
    UITextField *claimNumberTxt;
    VINDB *updateVINDB;
    
}

@property(nonatomic,retain) NSString *vinnumber;
@property(nonatomic,retain) NSString *techname;
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;
- (void) callWebService;
-(NSString *) formatIdentificationNumber:(NSString *)string;
@end
