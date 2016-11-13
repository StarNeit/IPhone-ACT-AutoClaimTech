//
//  PDRViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellView.h"
#import "CameraViewController.h"
#import "Charges.h"
#import "NotesViewController.h"
#import "VINDB.h"


typedef enum {
	ACTTBRowRemoveBtn        = 1000,
    ACTTBRowPicker1Btn       = 2000,
    ACTTBRowPicker2Btn       = 3000,
    ACTTBRowPicker3Btn       = 4000,
    ACTTBRowPickerTotallbl   = 5000,
    ACTTBRowlabel            = 6000
} ACTTBRow;

@interface PDRViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
   // NSManagedObjectContext *managedobject;
    UITableView *tableview;
    UIPickerView *pickerview;
    UIPickerView *pickerview1;
    UIPickerView *pickerview2;
    UIPickerView *pickerview3;
    UIPopoverController *popoverController;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    NSMutableDictionary *btnTag;
    UILabel *Total;
    
    Charges *chargesRateCls;
    NSMutableArray *chargesArray;
    
    UIAlertView *progressAlert;
    UIActivityIndicatorView *activityView;
    VINDB *updateVINDB;
    
    UIButton *overareabtn;
    UIButton *overdentbtn;
    UILabel *overtotallbl;
}
@property(nonatomic)NSInteger *enteraction;
@property(nonatomic,retain) NSManagedObjectContext *managedobject;
- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer;
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame ;


-(void) callgetData;
-(void) total;
-(void) act;
@end
