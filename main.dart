import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estudo Animação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      home: MyHomePage(title: 'Estudo Animação - Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation animUser;
  Animation animPass;
  Animation animOpacity;
  Animation animButtonWidth;
  Animation animButtonCirc;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animUser = Tween<double>(begin: 0.0, end: 365.0).animate(
        CurvedAnimation(parent: animController, curve: Interval(0.0, 0.5,curve: Curves.bounceOut)));
    animPass = Tween<double>(begin: 0.0, end: 365.0).animate(
        CurvedAnimation(parent: animController, curve: Interval(0.0, 0.5,curve: Curves.bounceOut)));
    animOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(curve: Interval(0.2, 0.6,curve: Curves.easeInOut),parent: animController));
    animButtonWidth =
        Tween<double>(begin: 300.0, end: 55.0).animate(CurvedAnimation(curve: Interval(0.0, 0.4,curve: Curves.bounceOut),parent: animController));
    animButtonCirc =
        Tween<double>(begin: 10.0, end: 40.0).animate(CurvedAnimation(curve: Interval(0.0, 0.4,curve: Curves.bounceOut),parent: animController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 70,
                        ),
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuário',
                          hintText: 'Usuário'),
                    ),
                  ),
                  animation: animUser,
                  builder: (BuildContext context, Widget child) {
                    return Transform.translate(
                      offset: Offset(animUser.value, 0.0),
                      child: child,
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: animPass,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                          hintText: '*******'),
                    ),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return Transform.translate(
                      offset: Offset(animPass.value * -1, 0.0),
                      child: child,
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: animOpacity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                        child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    )),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: animOpacity.value,
                      child: child,
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: animController,
                  builder: (BuildContext context, Widget child) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(animButtonCirc.value)),
                          child: Center(
                              child: animController.value > 0
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'ENTRAR',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                          height: 50,
                          width: animButtonWidth.value,
                        ),
                        onPressed: () {
                          if (animController.value > 0) {
                            animController.reverse();
                          } else
                            animController.forward();
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
