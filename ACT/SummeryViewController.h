//
//  SummeryViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDR1ViewController.h"

@interface SummeryViewController : UIViewController
{
    UITableView *tableview;
}
-(UILabel *) customlbl:(CGRect)frame lblTXt:(NSString *)str lblFont:(UIFont *)font lblColor:(UIColor *) color;
-(NSString*) getData:(id)val;
@end
