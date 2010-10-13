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
#import "HansardView.h"

@implementation RepView
@synthesize rep;
@synthesize nameLabel;
@synthesize division;
@synthesize house;
@synthesize party;
@synthesize date_elected;
@synthesize iview;
@synthesize map;

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
	CLLocationCoordinate2D location;
	double *width;
	double *breadth;
	nameLabel.text = (@"%@", rep.fullName);
	division.text = (@"%@", rep.constituency);
	party.text = (@"%@", rep.partyName);
	NSLog(@"House type: %@", rep.houseIdentifier);
	if([rep.houseIdentifier isEqualToString:@"1"])
	{
		house.text = @"House of Representatives";
	} else 
	{
		house.text = @"Senate";
		if([rep.constituency isEqualToString:@"NSW"]){
			location.latitude = -32.24643;
			location.longitude = 148.59511;
			map.region = MKCoordinateRegionMakeWithDistance(location, 1000000,1000000);
		} else if([rep.constituency isEqualToString:@"Vic"]){
			location.latitude = -36.742778;
			location.longitude = 144.326111;
			map.region = MKCoordinateRegionMakeWithDistance(location, 500000,500000);
		} else if([rep.constituency isEqualToString:@"Tas"]){
			location.latitude = -42.20817645934741;
			location.longitude = 146.7938232421875;
			map.region = MKCoordinateRegionMakeWithDistance(location, 250000,250000);
		} else if([rep.constituency isEqualToString:@"SA"]){
			location.latitude = -31.597253;
			location.longitude = 135.791016;
			map.region = MKCoordinateRegionMakeWithDistance(location, 750000,750000);
		} else if([rep.constituency isEqualToString:@"WA"]){
			location.latitude = -25.328056;
			location.longitude = 122.298333;
			map.region = MKCoordinateRegionMakeWithDistance(location, 1500000,1500000);
		} else if([rep.constituency isEqualToString:@"Queensland"]){
			location.latitude = -22.320278;
			location.longitude = 144.431667;
			map.region = MKCoordinateRegionMakeWithDistance(location, 1000000,1500000);
		} else if([rep.constituency isEqualToString:@"ACT"]){
			location.latitude = -35.49;
			location.longitude = 149.001389;
			map.region = MKCoordinateRegionMakeWithDistance(location, 100000,100000);
		} else if([rep.constituency isEqualToString:@"NT"]){
			location.latitude = -19.383333;
			location.longitude = 133.357778;
			map.region = MKCoordinateRegionMakeWithDistance(location, 1000000,1000000);
		}
		 
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

-(IBAction)closeView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)repHansard:(id)sender
{
	HansardView *hview = [[HansardView alloc] initWithNibName:nil bundle:nil];
	if([rep.houseIdentifier isEqualToString:@"1"]){
		hview.houseType = @"representatives";
	} else {
		hview.houseType = @"senate";
	}
	hview.person = rep.personIdentifier;
	
	[self presentModalViewController:hview animated:YES];
	
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
