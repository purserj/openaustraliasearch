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
#import "RepObject.h"

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
		urlString = [urlString stringByAppendingFormat:@"&search=%@", searchTerm];
	}
	NSLog(@"URL: %@", urlString);
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
		NSLog(@"Returned String: %@", jsonString);
		
		NSArray *results = [jsonString yajl_JSON];
		
		// TODO: create an array of representative objects by getting the
		//       relevant values out of the array of dictionaries.
		NSLog(@"Count %i", [results count]);
		
		NSMutableArray *representatives = [[NSMutableArray alloc] initWithCapacity:results.count];
		
		for (NSDictionary *representativeDict in results) {
			BOOL resType = [representativeDict isKindOfClass:[NSString class]];
			if(resType == YES){
				NSLog(@"error check");
			} else {
				RepObject *representative = [[RepObject alloc] init];
				if([representativeDict objectForKey:@"name"] != NULL){
					[representative setFullName:[representativeDict valueForKey:@"name"]];
				} else {
					[representative setFirstName:[representativeDict valueForKey:@"first_name"]];
					[representative setLastName:[representativeDict valueForKey:@"last_name"]];
					[representative setFullName:[representativeDict valueForKey:@"full_name"]];
				}
				[representative setPartyName:[representativeDict valueForKey:@"party"]];
				[representative setConstituency:[representativeDict valueForKey:@"constituency"]];	
				[representative setPersonIdentifier:[representativeDict valueForKey:@"person_id"]];
				[representative setHouseIdentifier:@"1"];
				[representatives addObject:representative];
				[representative release];
				
				for (NSString *key in [representativeDict allKeys]) {
					NSLog(@"%@:", key);
				}
			}
		}
		
		
		// TODO: call the delegate method with the array of representatives
		if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(serviceController:foundRepresentatives:)]) {
			[self.delegate serviceController:self foundRepresentatives:representatives];
		}
		
		[connection release];
	}
}


- (void)dealloc {
	[super dealloc];
	[delegate release];
}

@end
