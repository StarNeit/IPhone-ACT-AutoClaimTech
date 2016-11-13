//
//  CellView.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UITableViewCell
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UILabel *label;
    
}
@property (nonatomic, retain)UIButton *btn1;
@property (nonatomic, retain)UIButton *btn2;
@property (nonatomic, retain)UIButton *btn3;
@property (nonatomic, retain)UILabel *label;

@end
