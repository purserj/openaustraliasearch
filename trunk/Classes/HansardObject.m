//
//  HansardObject.m
//  openaustraliasearch
//
//  Created by James Purser on 6/10/10.
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


#import "HansardObject.h"


@implementation HansardObject

@synthesize parent;
@synthesize body;
@synthesize date;
@synthesize link;

-(void)dealloc {
	[super dealloc];
	[parent release];
	[body release];
	[date release];
	[link release];
}

@end
