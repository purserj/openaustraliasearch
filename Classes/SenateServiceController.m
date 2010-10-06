//
//  SenateServiceController.m
//  openaustraliasearch
//
//  Created by James Purser on 28/09/10.
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


#import "SenateServiceController.h"
#import "NSObject+YAJL.h"
#import "RepObject.h"

@implementation SenateServiceController

@synthesize delegate;

- (void)searchForSenatorsByState:(NSString *)state{
	stateStr = state;
	NSString *urlString = [NSString stringWithFormat:@"http://www.openaustralia.org/api/getSenators?key=Dx3bPFCRAQhCA99zCWGRup3C&output=js&"];
	if (state!=nil) {
		urlString = [urlString stringByAppendingFormat:@"&state=%@", state];
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
		
		NSArray *results = [jsonString yajl_JSON];
		
		// TODO: create an array of representative objects by getting the
		//       relevant values out of the array of dictionaries.
		NSMutableArray *senators = [[NSMutableArray alloc] initWithCapacity:results.count];
		
		for (NSDictionary *representativeDict in results) {
			
			RepObject *representative = [[RepObject alloc] init];
			[representative setFullName:[representativeDict valueForKey:@"name"]];
			[representative setPartyName:[representativeDict valueForKey:@"party"]];
			[representative setPersonIdentifier:[representativeDict valueForKey:@"person_id"]];
			[representative setConstituency:stateStr];
			[representative setHouseIdentifier:@"2"];

			[senators addObject:representative];
			[representative release];
			
			for (NSString *key in [representativeDict allKeys]) {
				NSLog(@"%@: %@", key, [representativeDict valueForKey:key]);
			}
		}
		
		
		// TODO: call the delegate method with the array of representatives
		if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(serviceController:foundSenators:)]) {
			[self.delegate serviceController:self foundSenators:senators];
		}
		
		[connection release];
	}
}

@end
