//
//  HansardView.m
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


#import "HansardView.h"
#import "HansardObject.h"
#import "WebView.h"


@implementation HansardView
@synthesize houseType;
@synthesize person;
@synthesize resultTable;
@synthesize results;
@synthesize hansObjs;


/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
            }
    return self;
}
*/

#pragma mark -
#pragma mark HansardServiceController Delegate Methods


- (void)serviceController:(id)controller foundHansResults:(NSMutableArray *)hansresults
{
	results = [NSMutableArray new];
	hansObjs = [NSMutableArray new];
	for(HansardObject *hans in hansresults)
	{
		NSString *hansString = [NSString stringWithFormat:@"%@\n %@", hans.date, hans.body];
		NSLog(@"Listurl: %@", hans.link);
		hansString = [hansString stringByReplacingOccurrencesOfString:@"&#8212;" withString:@"-"];
		hansString = [hansString stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
		[results addObject:hansString];
	}
	hansObjs = hansresults;
	[results retain];
	[resultTable reloadData];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	HansardServiceController *controller = [[HansardServiceController alloc] init];
	[controller setDelegate:self];
	[controller getHansardResults:houseType date:nil person:person];
	
	    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
	}	


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)closeView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [results count];
	return [results count];
	NSLog(@"wheeeee - %d", [results count]);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    } else{
		UIView *tView = [cell viewWithTag:100];
        [tView removeFromSuperview];
	}
	/*UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 90, 50)];
	label.tag = 100;
	label.numberOfLines = 2;
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.text = [results objectAtIndex:indexPath.row];
	[cell addSubview:label];
	[label release];*/
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.textLabel.text = [results objectAtIndex:indexPath.row]; 
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [results objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	HansardObject *hobj = (HansardObject *)[hansObjs objectAtIndex:indexPath.row];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	WebView *wview = [[WebView alloc] initWithNibName:nil bundle:nil];
	wview.hansObj = hobj;
	NSLog(@"Link: %@", hobj.link);
	[self presentModalViewController:wview animated:YES];
}


- (void)dealloc {
    [super dealloc];
}


@end
