import 'package:flutter/material.dart';
import 'package:Hodomojo/PopupView.dart';

// This class defines the view for the HomeScreen
// which is the first screen of the application.
class HomeScreen extends StatefulWidget {
  static const String id = "homeScreen";
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // showPopupView is used to determine if popupView is visible
  // and to adjust related behaviors.
  bool showPopupView = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        // This stack contains all the UI elements which are children
        // of the home screen.
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: showPopupView ? 0.5 : 1.0,
                  child: Container(
                    color: Colors.orange,
                  ),
                ),
                GestureDetector(
                  // A gesture detector within the stack is used
                  // for navigation while using popups instead of
                  // routes for different screens.
                  onTap: (){
                    try {
                      setState(() {
                        // This is useful when a popup is visible on the screen
                        // although the gesture is detected even when popup is
                        // not present. This can be prevented using a hit-test
                        // for the popup screen if needed.
                        showPopupView = false;
                      });
                    } catch (e, s) {
                      print(s);
                    }
                  },
                ),
                // Whether or not a button is shown depends on whether
                // the popup is already visible on the screen
                Visibility(visible: !showPopupView, child: showPopupButton()),
                Visibility(visible: showPopupView, child: PopupView())
              ],
            )),
      onWillPop: ()async{
        // If back button is pressed while popupView is visible
        // the popup is dismissed.
        // If the popupView is not visible when the back button is
        // pressed, the app is dismissed.
        if (showPopupView) {
          setState(() {
            showPopupView = false;
          });
          return false;
        }
        else
          return true;
      },
    );
    }
  Center showPopupButton() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () {
            setState(() {
              showPopupView = true;
            });
          },
          child: Container(
            height: 250,
            width: 250,
            color: Colors.white,
            child: Center(
              child: Text(
                'Click Here',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

