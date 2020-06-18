import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loja_to_hero/models/user_model.dart';
import 'package:loja_to_hero/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        title: Text(
          "Entrar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar Conta",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ));
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          Future<void> _googleSignUp() async {
            //Google
            try {
              GoogleSignIn _googleSignIn = GoogleSignIn(
                scopes: <String>[
                  'email',
                ],
              );
              final FirebaseAuth _auth = FirebaseAuth.instance;

              final GoogleSignInAccount googleUser =
                  await _googleSignIn.signIn();
              final GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;

              final AuthCredential credential =
                  GoogleAuthProvider.getCredential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              final FirebaseUser user =
                  (await _auth.signInWithCredential(credential).then((user) {
                print("signed in " + user.displayName);
                model.signUpGoogle(user);
              }));
              _onSuccess();
              return user;
            } catch (e) {
              _onFail();
            }
          }

          Future<void> signUpWithFacebook() async {
            try {
              var facebookLogin = new FacebookLogin();
              var result = await facebookLogin.logIn(['email']);

              if (result.status == FacebookLoginStatus.loggedIn) {
                final AuthCredential credential =
                    FacebookAuthProvider.getCredential(
                  accessToken: result.accessToken.token,
                );
                final FirebaseUser user = (await FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((user) {
                  print("signed in " + user.displayName);
                }));
                return user;
              }
            } catch (e) {
              print(e.message);
            }
          }

          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(
                16.0,
              ),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail inválido!";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida!";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty)
                        _scaffolKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Insira seu e-mail!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      else {
                        model.recoverPass(_emailController.text);
                        _scaffolKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Verifique sua caixa de e-mail"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSucess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Login com o Google',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    color: Colors.red,
                    onPressed: () async {
                      _googleSignUp();
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Login com o Facebook',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    color: Colors.blue[900],
                    onPressed: () {
                      print(signUpWithFacebook());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffolKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao Realizar Login!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
