# Introduction #

This document is a very rough design document for the Open Australia Search App for iphones/ipod touch and ipads.

# Purpose #

The purpose of this app is to allow users of apples mobile technologies to utilise the information contained within the OpenAustralia website. It will do this by interacting with the OpenAustralia api (JSON) and then presenting the information in a variety of different formats to the user.

# Details #

The following is a rough breakdown of the functionality that will be required:

## House of Reps Search ##

Users need to be able to search for a specific Member of the House of Representatives using any of the following values:

**Rep Name**

**Post Code**

**Division Name**

**Party**

Results will be returned in a list containing an image, name and party. Selecting the image will then open a new view as detailed in the Reps Display section.

## Senate Search ##

Searching for Senators will be slightly different to searching for HoR reps. The following search variables may be used.

**Party**

**State**

**Name**

## Hansard Search ##

Hansard search uses the following variables (note that House is required):

**House**

**Keyword**

**Date**

The results would be displayed in a list containing a snippet of the resulting debate. Clicking on the snippet would then take the user to a web view that displayed the full debate item on the OpenAustralia site.

## Reps Display ##

The reps display view is what the user will see once they have selected a rep from either the House of Reps Search or Senate search. It will contain the following:

Name

Image of Rep

Personal Info (Date entered parliament, division, political party, current office if any)

Scrollable list of last 10 hansard entries