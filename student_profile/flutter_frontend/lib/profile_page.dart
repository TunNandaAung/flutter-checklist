import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'data/profile_api_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String major;
  String rollNo;
  String uno;
  String startYear;
  String mmName;
  String enName;
  String nationality;
  String religion;
  String phone;
  String hometown;
  String township;
  String nrc;
  String dateOfBirth;
  String bloodtype;
  String matriRollNo;
  String matriYear;
  String matriDept;

  String mmFName;
  String enFName;
  String fnationaity;
  String freligion;
  String fhometown;
  String ftownship;
  String fphoneNo;
  String fnrc;
  String fjob;
  String fposition;
  String fdepartment;
  String faddress;

  String mmMName;
  String enMName;
  String mnationality;
  String mreligion;
  String mhometown;
  String mtownship;
  String mphoneNo;
  String mnrc;
  String mjob;
  String mposition;
  String mdepartment;
  String maddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text('My Profile')),
        endDrawer: new Drawer(
            child: new Column(children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("username",
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)),
            accountEmail: new Text(
              "firstname@lastname.com",
              style: new TextStyle(color: Colors.blueGrey[50]),
            ),
            currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.brown, child: new Text("FL")),
          ),
          new ListTile(
            leading: Icon(Icons.account_circle),
            title: new Text('My Profiles'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
//              new ListTile(
//                leading: Icon(Icons.center_focus_strong),
//                title: new Text('KBZpay QR Code'),
//                onTap: () {
//                  Navigator.of(context).pop();
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: ( BuildContext context ) => new Qr()));
//                },
//              ),
          new ListTile(
            leading: Icon(Icons.error_outline),
            title: new Text('Terms & Regulations'),
            onTap: () {
              this.setState(() {
                var screen = 0;
              });
              Navigator.pop(context);
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(Icons.power_settings_new),
            title: new Text('Logout'),
            onTap: () {},
          ),
        ])),
        body: FutureBuilder<Response>(
            // TODO: pass ID parameter from previous page
            future: Provider.of<ProfileApiService>(context).getProfile(3),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final Map profile = json.decode(snapshot.data.bodyString);
                return Container(
                  color: Colors.white,
                  child: new ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: new Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Personal Information',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status
                                                    ? _getEditIcon()
                                                    : new Container(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'မေဂျာ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'ခုံအမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: TextFormField(
                                                  initialValue: '',
                                                  onSaved: (value) =>
                                                      major = value,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "မေဂျာ"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['lastRollNo'],
                                                onSaved: (value) =>
                                                    rollNo = value,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "ခုံအမှတ်"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['uno'],
                                                  onSaved: (value) =>
                                                      uno = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "တက္ကသိုလ်မှတ်ပုံတင်အမှတ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['startingyear'],
                                                onSaved: (value) =>
                                                    startYear = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမည်(မြန်မာလို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['mmSName'],
                                                onSaved: (value) =>
                                                    mmName = value,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "အမည်(မြန်မာလို)",
                                                ),
                                                enabled: !_status,
                                                autofocus: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမည်(အင်္ဂလိပ်လို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['enSName'],
                                                onSaved: (value) =>
                                                    enName = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမည်(အင်္ဂလိပ်လို)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'လူမျိုး',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'ကိုးကွယ်သည့်ဘာသာ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['nationality'],
                                                  onSaved: (value) =>
                                                      nationality = value,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "လူမျိုး"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['religion'],
                                                onSaved: (value) =>
                                                    religion = value,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "ကိုးကွယ်သည့်ဘာသာ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'ဖုန်းနံပါတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'မွေးဖွားရာဇာတိ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['phoneNo'],
                                                  onSaved: (value) =>
                                                      phone = value,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "ဖုန်းနံပါတ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['hometown'],
                                                onSaved: (value) =>
                                                    hometown = value,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "မွေးဖွားရာဇာတိ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'မြို့နယ်/ပြည်နယ်/တိုင်း',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['township'],
                                                onSaved: (value) =>
                                                    township = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "မြို့နယ်/ပြည်နယ်/တိုင်း"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'မှတ်ပုံတင်အမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['nrc'],
                                                onSaved: (value) => nrc = value,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "မှတ်ပုံတင်အမှတ်"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'မွေးသက္ကရာဇ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'သွေးအုပ်စု',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['dateOfBirth'],
                                                  onSaved: (value) =>
                                                      dateOfBirth = value,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "မွေးသက္ကရာဇ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['bloodtype'],
                                                onSaved: (value) =>
                                                    bloodtype = value,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "သွေးအုပ်စု"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုံအမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုနှစ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['matriRollNo'],
                                                  onSaved: (value) =>
                                                      matriRollNo = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုံအမှတ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['matriYear'],
                                                onSaved: (value) =>
                                                    matriYear = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုနှစ်"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်စာစစ်ဌာန',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                onSaved: (value) =>
                                                    matriDept = value,
                                                initialValue: profile['data']
                                                    ['matriexamdept'],
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်စာစစ်ဌာန"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမြဲတမ်းနေထိုင်သည့်လိပ်စာ(အပြည့်အစုံ)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['address'],
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမြဲတမ်းနေထိုင်သည့်လိပ်စာ(အပြည့်အစုံ)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏အမည်(မြန်မာလို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['mmFName'],
                                                onSaved: (value) =>
                                                    mmFName = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏အမည်(မြန်မာလို)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏အမည်(အင်္ဂလိပ်လို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['enFName'],
                                                onSaved: (value) =>
                                                    enFName = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏အမည်(အင်္ဂလိပ်လို)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အဘအုပ်ထိန်းသူ၏လူမျိုး',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အဘအုပ်ထိန်းသူ၏ကိုးကွယ်သည့်ဘာသာ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['33'],
                                                  onSaved: (value) =>
                                                      fnationaity = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "အဘအုပ်ထိန်းသူ၏လူမျိုး"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['34'],
                                                onSaved: (value) =>
                                                    freligion = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏ကိုးကွယ်သည့်ဘာသာ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အဘအုပ်ထိန်းသူ၏ဖုန်းနံပါတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အဘအုပ်ထိန်းသူ၏မွေးဖွားရာဇာတိ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: '',
                                                  onSaved: (value) =>
                                                      fphoneNo = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "အဘအုပ်ထိန်းသူ၏ဖုန်းနံပါတ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['35'],
                                                onSaved: (value) =>
                                                    fhometown = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏မွေးဖွားရာဇာတိ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏မြို့နယ်/ပြည်နယ်/တိုင်း',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['36'],
                                                onSaved: (value) =>
                                                    ftownship = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏မြို့နယ်/ပြည်နယ်/တိုင်း"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏မှတ်ပုံတင်အမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['38'],
                                                onSaved: (value) =>
                                                    fnrc = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏မှတ်ပုံတင်အမှတ်"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['job'],
                                                onSaved: (value) =>
                                                    fjob = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏ရာထူး',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['position'],
                                                onSaved: (value) =>
                                                    fposition = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏ရာထူး"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏အလုပ်ဌာန',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['department'],
                                                onSaved: (value) =>
                                                    fdepartment = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏အလုပ်ဌာန"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အဘအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['f_address'],
                                                onSaved: (value) =>
                                                    faddress = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အဘအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏အမည်(မြန်မာလို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['mmMName'],
                                                onSaved: (value) =>
                                                    mmMName = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏အမည်(မြန်မာလို)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏အမည်(အင်္ဂလိပ်လို)',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['enMName'],
                                                onSaved: (value) =>
                                                    enMName = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏အမည်(အင်္ဂလိပ်လို)"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အမိအုပ်ထိန်းသူ၏လူမျိုး',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အမိအုပ်ထိန်းသူ၏ကိုးကွယ်သည့်ဘာသာ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: profile['data']
                                                      ['49'],
                                                  onSaved: (value) =>
                                                      mnationality = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "အမိအုပ်ထိန်းသူ၏လူမျိုး"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['50'],
                                                onSaved: (value) =>
                                                    mreligion = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏ကိုးကွယ်သည့်ဘာသာ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အမိအုပ်ထိန်းသူ၏ဖုန်းနံပါတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'အမိအုပ်ထိန်းသူ၏မွေးဖွားရာဇာတိ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextFormField(
                                                  initialValue: '',
                                                  onSaved: (value) =>
                                                      mphoneNo = value,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "အမိအုပ်ထိန်းသူ၏ဖုန်းနံပါတ်"),
                                                  enabled: !_status,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['51'],
                                                onSaved: (value) =>
                                                    mhometown = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏မွေးဖွားရာဇာတိ"),
                                                enabled: !_status,
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏မြို့နယ်/ပြည်နယ်/တိုင်း',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['52'],
                                                onSaved: (value) =>
                                                    mtownship = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏မြို့နယ်/ပြည်နယ်/တိုင်း"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏မှတ်ပုံတင်အမှတ်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['54'],
                                                onSaved: (value) =>
                                                    mnrc = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏မှတ်ပုံတင်အမှတ်"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏အလုပ်အကိုင်',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['56'],
                                                onSaved: (value) =>
                                                    mjob = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏အလုပ်အကိုင်"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏ရာထူး',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['57'],
                                                onSaved: (value) =>
                                                    mposition = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏ရာထူး"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏အလုပ်ဌာန',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['58'],
                                                onSaved: (value) =>
                                                    mdepartment = value,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏အလုပ်ဌာန"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'အမိအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: profile['data']
                                                    ['m_address'],
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "အမိအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ"),
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    !_status
                                        ? _getActionButtons(
                                            context,
                                            profile['data']['s_f_id'],
                                            profile['data']['s_m_id'])
                                        : new Container(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(BuildContext context, String fID, String mID) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  print('pressed');
                  _formKey.currentState.save();
                  final response = await Provider.of<ProfileApiService>(context)
                      .editProfile({
                    'id': 3,
                    'uno': uno,
                    'lastRollNo': rollNo,
                    'startingyear': startYear,
                    'mmSName': mmName,
                    'enSName': enName,
                    'nationality': nationality,
                    'religion': religion,
                    'phoneNo': phone,
                    'hometown': hometown,
                    'township': township,
                    'nrc': nrc,
                    'dateOfBirth': dateOfBirth,
                    'bloodtype': bloodtype,
                    'matriRollNo': matriRollNo,
                    'matriYear': matriYear,
                    'matriexamdept': matriDept,
                    'mmFName': mmFName,
                    'enFName': enFName,
                    'f_id': int.parse(fID),
                    'f_nationality': fnationaity,
                    'f_religion': freligion,
                    'f_hometown': fhometown,
                    'f_township': ftownship,
                    'f_phoneNo': fphoneNo,
                    'f_nrc': fnrc,
                    'f_job': fjob,
                    'f_department': fposition,
                    'f_position': fdepartment,
                    'f_address': faddress,
                    'mmMName': mmMName,
                    'enMName': enMName,
                    'm_id': int.parse(mID),
                    'm_nationality': mnationality,
                    'm_religion': mreligion,
                    'm_hometown': mhometown,
                    'm_township': mtownship,
                    'm_phoneNo': mphoneNo,
                    'm_nrc': mnrc,
                    'm_job': mjob,
                    'm_department': mposition,
                    'm_position': mdepartment,
                    'm_address': maddress,
                  });
                  //Map<String, dynamic> user = json.decode(response.body);
                  print(response.body);
                  if (response.statusCode == 200) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        content: Text('Profile Updated',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        backgroundColor: Color(0xFF2d3447),
                        duration: Duration(seconds: 2)));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        content: Text('Error Updating Profile!',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        backgroundColor: Color(0xFF2d3447),
                        duration: Duration(seconds: 2)));
                  }

                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
