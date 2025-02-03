import 'package:bank/view/home_page.dart';
import 'package:bank/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
          );
        }
        final session =snapshot.hasData ? snapshot.data!.session:null;

        if(session!=null)
        {
          return HomePage();
        }else{
          return LoginPage();
        }
      });
  }
}