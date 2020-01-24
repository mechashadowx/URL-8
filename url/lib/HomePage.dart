import 'package:flutter/material.dart';
import 'package:url/helper.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  int onOff;
  String up, url;

  @override
  void initState() {
    super.initState();
    up = url = '';
    onOff = 0;
  }

  getState() async {
    if (onOff == 1) return;
    setState(() {
      up = 'Wait';
      onOff = 1;
    });
    bool chack = await getJsonData();
    setState(() {
      if (chack) {
        up = 'UP';
      } else {
        up = 'DOWN';
      }
    });
  }

  Future<bool> getJsonData() async {
    String editedUrl = 'https://downforeveryoneorjustme.com/' + url;
    var response = await http.get(
      editedUrl,
    );
    String x = response.toString();
    return x.contains('It\'s just you. ');
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    margin: EdgeInsets.symmetric(
                        horizontal: data.size.width * 0.05),
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: gray,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.circular(data.size.width * 0.05),
                          ),
                          child: Center(
                            child: TextFormField(
                              onChanged: (input) {
                                this.url = input;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: gray,
                                fontSize: data.size.width * 0.06,
                                fontWeight: FontWeight.w600,
                              ),
                              cursorColor: gray,
                              maxLines: 1,
                              decoration: InputDecoration.collapsed(
                                border: InputBorder.none,
                                hintText: 'URL',
                                hintStyle: TextStyle(
                                  color: lightGray,
                                  fontSize: data.size.width * 0.06,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Text(
                        'The Website is :',
                        style: TextStyle(
                          color: red,
                          fontSize: data.size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: this.up != 'Wait'
                          ? Text(
                              this.up,
                              style: TextStyle(
                                color: gray,
                                fontSize: data.size.width * 0.1,
                              ),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: getState,
                child: Container(
                  child: Center(
                    child: IndexedStack(
                      index: this.onOff,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                            'assets/off.png',
                          ),
                          height: data.size.width * 0.4,
                          width: data.size.width * 0.4,
                        ),
                        Image(
                          image: AssetImage(
                            'assets/on.png',
                          ),
                          height: data.size.width * 0.4,
                          width: data.size.width * 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
