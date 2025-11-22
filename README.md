# COOK! App
## Ben Quackenbush, Colin Butera, Lex Witkin, Sam Zimpfer

## Overview
This app is a basic recipe library and builder. Users can create and save recipes, 
add ingredients to grocery list, add ingredients to pantry, create recipes using current ingredients, and schedule recipes. 
Users can also scan ingredients directly into their pantry as well.  The schedule can also be added to calendar.

## Notes
Its best to test app by building due to AppState controlling global variables like coloring and master item lists.
Sometimes, text will appear white, but turning off dark mode will fix the issue for now.
Barcode scanner only works for about 60-90 seconds after app build due to the API. We're using the free trial plan
because the paid API plans for both the scanner and UPC Barcode database were rediculously expensive.
We also have limited API calls available. There are around 45 remaining at time of submission.
You MUST hit submit after scanning a barcode in order for the ingredient to load into the pantry properly.
While the list is exaustive, it works best on more common foods and ingredients rather than niche products due to it being user sourced.
When creating a new user account, the recipe list will be blank, this is normal.  You must add a recipe for one to show up in libary.
Adding to calendar works, but does not prevent duplicate events due to write-only access.  If user does not have any accessable calendars on their phone
(i.e. subscription and private calendaras only, the system will throw an error to the console and user but the program will not crash.

## GoogleService-INFO.plist Note:
Due to the number of permissions required and the FirebaseAPI, we've had to do extensive plist editing.  Because of this, there will
sometimes be error when building if the plist cannot be correctly accessed. Sometimes this happens if git pull does not work properly.
Ensure you have a GoogleService-INFO.plist file in the COOK project folder as github can be finnicky with this.

This file in git also contains a placeholder for the firebase API key due to this being a public repo. If you download our zip from brightspace, the plist
includes the API key variable filled in properly so the firebase connection can be established.
