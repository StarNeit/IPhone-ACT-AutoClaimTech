//
//  signview.h
//  PersonalInformation
//
//  Created by Innoppl Technologies on 01/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface signview : UIImageView{
    
   // UIImageView *drawImage;
    CGPoint lastPoint;
    BOOL mouseSwiped;	
	int mouseMoved;
    CGPoint currentPoint;
}
- (void)drawRect:(CGRect)rect;
@end
