//
//  HTTP.h
//  LiquidSpins
//
//  Created by Lakshmanan v on 3/31/12.
//  Copyright 2012 Innoppl Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol requestdelegate 

@optional
-(void)didFinishLoading:(NSString *)response;
-(void)didFailWithError:(NSString *)error;

@end


@interface HTTP : NSObject {


		NSMutableData *receivedData;
		NSURL *url;
    id<requestdelegate>delegate;
}
@property (nonatomic,retain) NSMutableData *receivedData;
@property (retain) id delegate;
	
- (void)get: (NSString *)urlString;
- (void)post: (NSString *)urlString postData:(NSString*)data;
	
@end
