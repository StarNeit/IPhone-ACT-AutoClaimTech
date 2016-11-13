//
//  UIViewController+Present.m
//  ACT
//
//  Created by Lakshmanan V on 8/21/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "UIViewController+Present.h"

@implementation UIViewController(Extended)
-(void) presentNavigationController:(id)nav{
    
    [self presentModalViewController:nav animated:YES];
}
@end
