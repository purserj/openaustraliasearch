//
//  HansardServiceController.h
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


#import <Foundation/Foundation.h>

@protocol HansardServiceControllerDelegate <NSObject>

@optional
- (void)serviceController:(id)controller foundHansResults:(NSArray *)hansresults;

@end


@interface HansardServiceController : NSObject {
	
	id<HansardServiceControllerDelegate> delegate;
	
	NSURLConnection *connection;
	NSMutableData *data;
	NSString *jsonString;
	NSString *person;
	NSString *date;
	NSString *type;

}

@property (nonatomic, retain) id<HansardServiceControllerDelegate> delegate;
@property (nonatomic, retain) NSString *person;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *type;

-(void)getHansardResults:(NSString *)type date:(NSDate *)date person:(NSString *)person;

@end
