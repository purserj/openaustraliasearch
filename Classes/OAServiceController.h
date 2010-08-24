//
//  OAServiceController.h
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
//  This class provides a way to interact with the
//  Open Australia API.
//
//  Eg. to search for representatives:
//  controller = [[OAServiceController alloc] init];
//  [controller setDelegate:self];
//  [controller searchForRepresentativesWithPostcode:2615 date:[NSDate date] party:nil search:nil];
//
//  The above would result in a request to the Open Australia API and the following delegate
//  method would be called:
//  - (void)serviceController:(id)controller foundRepresentatives:(NSArray *)representatives;
//

#import <Foundation/Foundation.h>

@protocol OAServiceControllerDelegate <NSObject>

@optional
- (void)serviceController:(id)controller foundRepresentatives:(NSArray *)representatives;

@end


@interface OAServiceController : NSObject {
	
	id<OAServiceControllerDelegate> delegate;
	
	NSURLConnection *connection;
	NSMutableData *data;
	NSString *jsonString;
}

@property (nonatomic, retain) id<OAServiceControllerDelegate> delegate;

// Search for representatives using any of the possible search options.
// Each of the parameters is optional (provide -1 for 'postcode' if you don't want to specify a postcode).
- (void)searchForRepresentativesWithPostcode:(int)postcode date:(NSDate *)date party:(NSString *)party search:(NSString *)searchTerm;

@end
