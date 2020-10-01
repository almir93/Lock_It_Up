import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Lock_It_Up/ui/pages/mainProfile.dart';


class SettingMainTinder extends StatefulWidget {
  @override
  _SettingMainTinderState createState() => _SettingMainTinderState();
}

class _SettingMainTinderState extends State<SettingMainTinder> {
  double rating = 19.0;
  double whp = 200.0;

  Widget textField({hintText, left, right, top, bottom}) {
    return TextField(
      maxLength: 500,
      style: TextStyle(
          //color: Colors.white
          ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
          isDense: true,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
          //border: InputBorder.none
          ),
    );
  }

  Widget headingsForTextField({
    text,
    left,
    top,
    right,
    bottom,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget textField1({hintText, left, right, top, bottom}) {
    return TextField(
      style: TextStyle(
          //color: Colors.white
          ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
          isDense: true,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
          //border: InputBorder.none
          ),
    );
  }

  Widget interestInSex() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Show Me",
            style: TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "JDM",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget maximumDistance() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Maximum Distance",
                style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${rating.round()} Miles.",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          Slider(
            value: rating,
            onChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
            min: 0,
            max: 55,
            activeColor: Colors.red[400],
          )
        ],
      ),
    );
  }

    Widget maximumHorsepower() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Maximum Horsepower",
                style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${whp.round()} whp.",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          Slider(
            value: whp,
            onChanged: (newWhp) {
              setState(() {
                whp = newWhp;
              });
            },
            min: 0,
            max: 3000,
            
            activeColor: Colors.blue[400],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red[400],
          ),
          onPressed: () {
            Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => ProfileSetting()),
                 );
                  }
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              ],
            ),
            headingsForTextField(
              text: "Account Settings",
              left: 0.0,
              top: 20.0,
              right: 0.0,
              bottom: 12.0,
            ),
            textField1(
              hintText: "Phone Number",
              right: 16.0,
              top: 16.0,
              left: 16.0,
              bottom: 16.0,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Verify a phone number to help secure your account.",
              style: TextStyle(color: Colors.grey),
            ),
            headingsForTextField(
              text: "Discovery Settings",
              left: 0.0,
              top: 20.0,
              right: 0.0,
              bottom: 12.0,
            ),
            textField1(
              hintText: "Enter Location",
              right: 16.0,
              top: 16.0,
              left: 16.0,
              bottom: 16.0,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Change your location to see other racers in other cities",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 16,
            ),
            interestInSex(),
            SizedBox(
              height: 16,
            ),
            maximumDistance(),
            SizedBox(
              height:16
              ,),
            maximumHorsepower(),
          ],
        ),
      ),
    );
  }
}