import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logo = Image.asset("images/logo_v2lf.png");

  final userName = TextFormField(
    autofocus: false,
    decoration: InputDecoration(
        hintText: '用户名',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final password = TextFormField(
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
        hintText: '密码',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final captcha = Row(
    children: <Widget>[
      //Image.network("https://www.v2ex.com/_captcha?once=91648"),
      Flexible(
          child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
            hintText: '验证码',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      )),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: FadeInImage.assetNetwork(
            width: 158.0,
            height: 40.0,
            placeholder: "images/ic_sync_white_24dp.png",
            image: "https://ws1.sinaimg.cn/large/006tNbRwgy1fyfiufpg27j308w0280sq.jpg"),
      ),
    ],
  );

  final loginButton = Material(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(30.0),
    shadowColor: Colors.blueGrey.shade100,
    elevation: 5.0,
    child: MaterialButton(
      minWidth: 200.0,
      height: 48.0,
      onPressed: () {
        // todo 非空检查-登录判断结果
      },
      color: Colors.blueGrey,
      child: Text('Log In', style: TextStyle(color: Colors.white)),
    ),
  );

  final forgotLabel = FlatButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  final closePage = IconButton(
      icon: new Icon(
        Icons.close,
        size: 20.0,
      ),
      onPressed: () {
        //Navigator.of(context).pop();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.red[300],
        mini: true,
        child: Icon(Icons.close),
      ),
      body: new Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(
              height: 30.0,
            ),
            userName,
            SizedBox(
              height: 10.0,
            ),
            password,
            SizedBox(
              height: 10.0,
            ),
            captcha,
            SizedBox(
              height: 40.0,
            ),
            loginButton,
            forgotLabel,
            //closePage
          ],
        ),
      ),
    );
  }
}
