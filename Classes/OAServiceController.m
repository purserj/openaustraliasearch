//
//  OAServiceController.m
//  openaustraliasearch
//
//  Created by Jake MacMullin on 25/08/10.
//  Copyright 2010 Jake MacMullin.
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
//

#import "OAServiceController.h"
#import "NSObject+YAJL.h"

@implementation OAServiceController

@synthesize delegate;

- (void)searchForRepresentativesWithPostcode:(int)postcode date:(NSDate *)date party:(NSString *)party search:(NSString *)searchTerm {
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.openaustralia.org/api/getRepresentatives?key=Dx3bPFCRAQhCA99zCWGRup3C&output=js&"];
	if (postcode!=-1) {
		urlString = [urlString stringByAppendingFormat:@"&postcode=%i", postcode];
	}
	if (date!=nil) {
		urlString = [urlString stringByAppendingFormat:@"&date=%@", date];
	}
	if (party!=nil) {
		urlString = [urlString stringByAppendingFormat:@"&party=%@", party];
	}
	if (searchTerm!=nil) {
		urlString = [urlString stringByAppendingFormat:@"&searchTerm=%@", searchTerm];
	}
	
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
	
	// create a new connection (sends request immediately)
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[request release];
}


#pragma mark -
#pragma mark NSURLConnection Delegate Methods

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
		
		for (NSDictionary *representativeDict in results) {
			for (NSString *key in [representativeDict allKeys]) {
				NSLog(@"%@: %@", key, [representativeDict valueForKey:key]);
			}
		}
		
		
		// TODO: call the delegate method with the array of representatives
		
		
		[connection release];
	}
}


- (void)dealloc {
	[super dealloc];
	[delegate release];
}

@end
