import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Hodomojo/NetworkHelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PopupView extends StatefulWidget {
  @override
  _PopupViewState createState() => _PopupViewState();
}

class _PopupViewState extends State<PopupView> {
  bool spinner = false;
  String headerImg = '';
  String headerTitle = '';
  var textTitle = new Map();
  var textdesc = new Map();
  var img = new Map();
  var typeDictionary = new List.empty(growable: true);
  int componentLength = 0;

  NetworkHelper n2 = NetworkHelper();

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
    });
    initDataSource();
  }

  //This function parses the json file and fetches the
  // values for different types of widgets - Header, Text and Image.
  Future initDataSource() async {
    var dd = await n2.getdata();

    updateHeader(dd['data']['coverUrl'], dd['data']['title']);

    int itr = 0; // iterator to pass over the data components of the json
    componentLength = dd['data']['components'].length;

    while (itr < componentLength) {
      if (dd['data']['components'][itr]['type'] == 'text') {
        updateText(dd['data']['components'][itr]['title'],
            dd['data']['components'][itr]['desc'], itr);
      } else if (dd['data']['components'][itr]['type'] == 'image') {
        updateImage(dd['data']['components'][itr]['url'], itr);
      }
      itr++;
    }

    // The spinner is dismissed when data has been loaded successfully.
    setState(() {
      spinner = false;
    });
  }

  // These functions update the information about their respective
  // widget types.
  void updateHeader(String coverUrl, String title) {
    setState(() {
      headerImg = coverUrl;
      headerTitle = title;
    });
  }

  void updateText(String textTitleVal, String textDescVal, int index) {
    textTitle[index] = textTitleVal;
    textdesc[index] = textDescVal;
    typeDictionary.add("text");
  }

  void updateImage(String url, int index) {
    img[index] = url;
    typeDictionary.add("image");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 150, 16, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          child: spinner
              ? Spinner()
              : Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        radius: Radius.circular(70),
                        thickness: MaterialStateProperty.all(7.0),
                        trackColor: MaterialStateProperty.all(Colors.grey),
                        trackBorderColor:
                            MaterialStateProperty.all(Colors.grey),
                        minThumbLength: 10,
                        crossAxisMargin: 30,
                        mainAxisMargin: 30,
                        interactive: true),
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      // The total number of widgets includes
                      // the widgets in the components list
                      // and the header widget.
                      itemCount: componentLength + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return buildComponentWidget(index);
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // This function is responsible for determining
  // the type of widget to be created
  Widget buildComponentWidget(int value) {
    // In the event that the widget is not a header widget
    // 'index' denotes the index of the component.
    int index = value - 1;
    if (value == 0)
      return headerWidget();
    else if (typeDictionary[index] == "image")
      return imageWidget(index);
    else if (typeDictionary[index] == "text")
      return textWidget(index);
    else
      return defaultWidget();
  }

  // These functions are used to create different types of widgets
  Stack headerWidget() {
    return Stack(
      children: <Widget>[
        Container(
          height: 550,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('$headerImg'), fit: BoxFit.fill),
          ),
        ),
        Container(
          child: Positioned(
            left: 20,
            top: 485,
            child: Text(
              '$headerTitle',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageWidget(int index) {
    return Container(
      height: 400,
      color: Colors.white,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            '${img[index]}',
            height: 300.0,
            width: 300.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget textWidget(int index) {
    return Column(
      children: [
        Container(
          color: Colors.amberAccent[100],
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${textTitle[index]}',
              style: TextStyle(
                  fontSize: 17, color: Colors.grey[700], letterSpacing: 0.5),
            ),
          ),
        ),
        Container(
          color: Colors.amberAccent[100],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Text(
              '${textdesc[index]}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4),
            ),
          ),
        )
      ],
    );
  }
}
 // This function creates a default, empty widget
 Widget defaultWidget()
 {
   return Container();
 }

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: Colors.red,
      size: 30,
    );
  }
}
