//
//  RepView.m
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

#import "RepView.h"
#import "RepObject.h"




@implementation RepView
@synthesize rep;
@synthesize nameLabel;
@synthesize division;
@synthesize house;
@synthesize party;
@synthesize date_elected;
@synthesize iview;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//[rep setPartyName:@"Hello"];
	nameLabel.text = (@"%@", rep.fullName);
	division.text = (@"%@", rep.constituency);
	party.text = (@"%@", rep.partyName);
	if([rep.houseIdentifier isEqualToString:@"1"])
	{
		house.text = @"House of Representatives";
	} else 
	{
		house.text = @"Senate";
	}
	[self downloadImage];
	NSLog(@"%@", rep.houseIdentifier);
    [super viewDidLoad];
}

-(void)downloadImage {
	NSString *myString1=[NSString stringWithFormat:@"http://www.openaustralia.org/images/mpsL/%@.jpg", rep.personIdentifier];
	NSLog(myString1);
	NSURL *url1=[NSURL  URLWithString:myString1];
	UIImage *img1=[UIImage imageWithData:[NSData dataWithContentsOfURL:url1]];
	[self performSelectorOnMainThread:@selector(downloadDone:) withObject:img1 waitUntilDone:NO];
}

-(void)downloadDone:(UIImage*)theImage {
	
	[iview setImage:theImage];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
