//
//  HansardServiceController.m
//  openaustraliasearch
//
//  Created by James Purser on 1/09/10.
//  Copyright 2010 James Purser. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "HansardServiceController.h"
#import "NSObject+YAJL.h"
#import "HansardObject.h"


@implementation HansardServiceController

@synthesize delegate;

-(void)getHansardResults:(NSString *)type date:(NSDate *)date person:(NSString *)person
{
	NSString *urlString = [NSString stringWithFormat:@"http://www.openaustralia.org/api/getDebates?key=Dx3bPFCRAQhCA99zCWGRup3C&output=js&type=%@&",type];
	if(person != -1)
	{
		urlString = [urlString stringByAppendingFormat:@"person=%@", person];
	}
	
	NSLog(@"%@", urlString);
	
	
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
	
	// create a new connection (sends request immediately)
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[request release];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
	if (data==nil) {
		data = [[NSMutableData alloc] init];
	}
	[data appendData:someData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
	if (theConnection == connection) {
		jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		//NSLog(@"%@", jsonString);
		
		NSDictionary *results = [jsonString yajl_JSON];
		NSLog(@"Contains rows");
		NSDictionary *rows = [results objectForKey:@"rows"];
		

		// TODO: create an array of representative objects by getting the
		//       relevant values out of the array of dictionaries.
		NSMutableArray *hansresults = [[NSMutableArray alloc] initWithCapacity:results.count];
		
		for(NSArray *row in rows){
			HansardObject *hansObj = [[HansardObject alloc] init];
			[hansObj setBody:[row objectForKey:@"body"]];
			[hansObj setParent:[row objectForKey:@"parent"]];
			[hansObj setLink:[row objectForKey:@"listurl"]];
			[hansObj setDate:[row objectForKey:@"hdate"]];
			[hansresults addObject:hansObj];
			NSLog(@"Row: %@", [row objectForKey:@"body"]);
		}
		
		// TODO: call the delegate method with the array of representatives
		if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(serviceController:foundHansResults:)]) {
			[self.delegate serviceController:self foundHansResults:hansresults];
		}
		
		[connection release];
	}
	
	
}

@end
