//
//  RepObject.h
//  openaustraliasearch
//
//    Created by James Purser on 24/08/10.
//  Copyright 2010 James Purser
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


@interface RepObject : NSObject {
	
	NSString *personIdentifier;
	int memberIdentifier;
	NSString *houseIdentifier;	
	NSString *firstName;
	NSString *lastName;
	NSString *fullName;
	NSString *partyName;
	NSString *constituency;
	
}

@property (nonatomic, retain) NSString *personIdentifier;
@property (nonatomic) int memberIdentifier;
@property (nonatomic, retain) NSString *houseIdentifier;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *partyName;
@property (nonatomic, retain) NSString *constituency;

@end
