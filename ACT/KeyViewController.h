//
//  KeyViewController.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle_releaseViewController.h"
#import "ScanViewController.h"

@protocol KeyPadDelegate <NSObject>

@optional
-(void) willAddDismissView:(BOOL)isNavigate;
-(void) willDismissView;
@end

@interface KeyViewController : UIViewController
{
    UITextField *vintxt;
    id<KeyPadDelegate> delegate;
}
-(UITextField*) customTextfield:(NSString*)fieldType textName:(NSString*)str initFrame:(CGRect)frame;

@property (nonatomic) id delegate;

@end
