//
//  CreatePDF.h
//  ACT
//
//  Created by Innoppl Technologies on 26/07/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatePDF : NSObject{
    
    CGSize pageSize;
}

-(id) init;
-(void)drawText1;
-(void) drawImage1;
-(void) drawText2;
-(void) drawImage2;
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame;
-(void) drawPage1;
-(void) drawPage2;
-(void) drawPage3;


@end
