import 'package:flutter/material.dart';
import 'package:study_buddy/ui/home_page.dart';
import 'package:study_buddy/ui/shared/constants.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Study",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Buddy",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Refine your definitions",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                  elevation: 0.0,
                  height: 60.0,
                  minWidth: ScreenSize.screenWidth(context) * 0.45,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  color: Theme.of(context).buttonColor,
                  textTheme: Theme.of(context).buttonTheme.textTheme,
                  shape: Theme.of(context).buttonTheme.shape,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "Start studying",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )),
                      Expanded(child: Icon(Icons.perm_media)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
