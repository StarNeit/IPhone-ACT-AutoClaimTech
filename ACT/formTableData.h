//
//  formTableData.h
//  ACT
//
//  Created by Lakshmanan V on 8/19/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface formTableData : NSObject
{
    NSString *title;
    NSString *description;
    NSUInteger isDone;
    NSUInteger isProgress;
    UIImage *statusIcon;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) NSUInteger isDone;
@property (nonatomic) NSUInteger isProgress;
@property (nonatomic, retain) UIImage *statusIcon;


@end
