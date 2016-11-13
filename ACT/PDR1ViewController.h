//
//  PDR1ViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "NotesViewController.h"
#import "VINDB.h"

@interface PDR1ViewController : UIViewController
{
    UILabel *pdrlbl;
    UITextField *parttxt;
    UITextField *secondtxt;
    UILabel *grandlbl;
    UITableView *tableview;
    UILabel *heading;
    UILabel *estmatelbl;
    UILabel *partlbl;
    UILabel *secondlbl;
    UILabel *grand;
    VINDB *updateVINDB;
    
}

@property(nonatomic,retain)NSString *pdrtext;
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;
-(int) formatHour:(NSString*)txt;
-(NSString *) formatIdentificationNumber:(NSString *)string;
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame;

@end
