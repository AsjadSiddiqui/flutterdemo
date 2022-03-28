# example

# Problem
I created an app that is backed by firebase. Authentication as you will see is handled by firebase.
After successfull authentication I want to show the business logic of my app to the users.
For this I want to change the screen but somehow I receive an duplicate keys error right after login in.
What is the best practice for switching between authentication screens and business logic?


How to recreate the issue
- Install the app on a simulator of your choice (I used Iphone SE 2nd Generation)
- Once the app has started press login 
- On the login screen login with the given username and password by pressing login again
- You will be take into the business logic.
- Check the DEBUG console inside VS or Android Studio 


You should see the following error:

The following GlobalKeys were specified multiple times in the widget tree. This will lead to parts of the widget tree being truncated unexpectedly, because the second time a key is seen, the previous instance is moved to the new location. The keys were:
- [LabeledGlobalKey<NavigatorState>#41302]
  [LabeledGlobalKey<NavigatorState>#6ab77]
  [LabeledGlobalKey<NavigatorState>#891ed]
This was determined by noticing that after widgets with the above global keys were moved out of their previous parent, that previous parent never updated during this frame, meaning that it either did not update at all or updated before the widgets were moved, in either case implying that it still thinks that it should have a child with those global keys.
The specific parent that did not update after having one or more children forcibly removed due to GlobalKey reparenting is:
- TabNavigator (3 different affected elements had this toString representation)
A GlobalKey can only be specified on one widget at a time in the widget tree.
When the exception was thrown, this was the stack

  
# Solution
  My problem is solved if I can
  - Login and show busines logic with the best practice. Changing the navigator and showing the business logic without internal errors
  - Logout of the app without glitches and errors
