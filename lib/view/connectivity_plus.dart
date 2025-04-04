import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



//DA SE SMENI U MAIN.DART
//koga nema network da se proveri pomegju AuthCheck i NetworkCheck 
//ako nema togash kje displayne nesho slika kkao trska u voda
// demek cheka nema network i momentot koga kje dobie da bide pushten
//isto taka dur otvorena aplikacija dur snema net da stigne poraka no net
//nesho taka







class NetworkHandler extends StatefulWidget {
  const NetworkHandler({super.key});

  @override
  _NetworkHandlerState createState() => _NetworkHandlerState();
}

class _NetworkHandlerState extends State<NetworkHandler> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
  }

  void _checkNetworkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });

      if (!_isConnected) {
        _showOfflineMessage();
      } else {
        _fetchDataFromSupabase();
      }
    } as void Function(List<ConnectivityResult> event)?);
  }

  void _showOfflineMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No internet connection. Please check your network settings.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

Future<void> _fetchDataFromSupabase() async {
  try {

    final response = await Supabase.instance.client
        .from('your_table')
        .select();


    if (response.isEmpty) {
      print('No data found');
    } else {
      print('Fetched data: $response');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Connectivity Example'),
      ),
      body: Center(
        child: _isConnected
            ? Text('You are online')
            : Text('You are offline', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
