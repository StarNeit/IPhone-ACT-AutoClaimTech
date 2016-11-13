//
//  HTTP.m
//  LiquidSpins
//
//  Created by Lakshmanan v on 3/31/12.
//  Copyright 2012 Innoppl Technologies. All rights reserved.
//

#import "HTTP.h"


@implementation HTTP
@synthesize receivedData;
@synthesize delegate;

- init {
	if ((self = [super init])) {
 		
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}


- (void)setDelegate:(id)val
{
	delegate = val;
}

- (id)delegate
{
	return delegate;
}

- (void)get: (NSString *)urlString {
 	
 	//NSLog ( @"GET: %@", urlString );
	
 	self.receivedData = [[NSMutableData alloc] init];
 	
	NSURLRequest *request = [[NSURLRequest alloc]
 							 initWithURL: [NSURL URLWithString:urlString]
 							 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
 							 timeoutInterval:80
 							 ];
	
	NSURLConnection *connection = [[NSURLConnection alloc]
 								   initWithRequest:request
 								   delegate:self
 								   startImmediately:YES];
 	if(!connection) {
 		//NSLog(@"connection failed :(");
 	} else {
 		//NSLog(@"connection succeeded  :)");
 		
 	}
 	
 	[connection release];
	[request release];  
	[receivedData release];  
}




- (void)post: (NSString *)urlString postData:(NSString*)data
{
 	
 	// POST
      
    
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    

	
	NSURLConnection *connection = [[NSURLConnection alloc]
 								   initWithRequest:request
 								   delegate:self
 								   startImmediately:YES];
    
    
 	if(connection) {
 		self.receivedData = [[NSMutableData alloc] init];
 	} else {
 		self.receivedData = nil;
 		
 	}
 	
 	[connection release];
	[receivedData release];  
 	
}	

// ====================
// Callbacks
// ====================

#pragma mark NSURLConnection delegate methods
- (NSURLRequest *)connection:(NSURLConnection *)connection
 			 willSendRequest:(NSURLRequest *)request
 			redirectResponse:(NSURLResponse *)redirectResponse {
 	//NSLog(@"Connection received data, retain count");
	return request;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
 	//NSLog(@"Received response: %@", response);
 	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
 	//NSLog(@"Received %d bytes of data", [data length]); 
 	
	[receivedData appendData:data];
 	//NSLog(@"Received data is now %d bytes", [receivedData length]); 
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
 	NSLog(@"Error receiving response: %@", error);
	
	NSString *errorStr = [(NSError*)error localizedDescription];
    
    [[self delegate] didFailWithError:errorStr];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// Once this method is invoked, "responseData" contains the complete result
 	NSLog(@"Succeeded! Received %d bytes of data", [receivedData length]); 

 		NSString* dataAsString = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
    
    [[self delegate] didFinishLoading:dataAsString];
 		

}
@end
