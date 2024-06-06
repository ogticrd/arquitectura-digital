import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

final authorizationEndpoint =
    Uri.parse('https://cuenta.digital.gob.do/oauth2/auth');
final tokenEndpoint = Uri.parse('https://cuenta.digital.gob.do/oauth2/token');
final identifier = 'client_id';
final secret = 'client_secret';
final redirectUrl = Uri.parse('redirect_url');

Future<oauth2.Client> createClient() async {

  // If we don't have OAuth2 credentials yet, we need to get the resource owner
  // to authorize us. We're assuming here that we're a command-line application.
  var grant = oauth2.AuthorizationCodeGrant(
      identifier, authorizationEndpoint, tokenEndpoint,
      secret: secret);

  // A URL on the authorization server (authorizationEndpoint with some additional
  // query parameters). Scopes and state can optionally be passed into this method.
  var authorizationUrl = grant.getAuthorizationUrl(redirectUrl,
      scopes: ["openid", "email", "offline_access", "profile"],
      state: "12345678");

  // Redirect the resource owner to the authorization URL. Once the resource
  // owner has authorized, they'll be redirected to `redirectUrl` with an
  // authorization code. The `redirect` should cause the browser to redirect to
  // another URL which should also have a listener.

  await redirect(authorizationUrl);
  var responseUrl = await listen(redirectUrl);

  
  // Once the user is redirected to `redirectUrl`, pass the query parameters to
  // the AuthorizationCodeGrant. It will validate them and extract the
  // authorization code to create a new Client.
  return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
}

Future<Uri> listen(Uri url) async {
  final _appLinks = AppLinks();
  Completer<Uri> completer = Completer<Uri>();
  _appLinks.uriLinkStream.listen((uri) {
    if (uri.toString().startsWith(url.toString())) {
      completer.complete(uri);
    }
  });
  return completer.future;
}

Future<void> redirect(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OAuth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OAuth Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Implementar Autenticación'),
              ElevatedButton(
                  onPressed: () async {
                    var client = await createClient();

                    var headers = {
                      'Authorization': 'Bearer ${client.credentials.accessToken}',
                    };
                    //Get user info by doing an HTTP GET request
                    final response = await http.get(Uri.parse('https://cuenta.digital.gob.do/userinfo'),
                        headers: headers);

                    if (response.statusCode == 200) {
                      //Print the response in case it was succesfully retrieved
                      print(response.body);
                      setState(() {
                        name = jsonDecode(response.body)["given_name"];
                      });
                    }
                    else {
                      //Print the reason phrase in case the request failed
                      print(response.reasonPhrase);
                    }

                  },
                  child: const Text("Iniciar sesión con Cuenta Única")),
                  Text(name)
            ],
          ),
        ),
      ),
    );
  }
}