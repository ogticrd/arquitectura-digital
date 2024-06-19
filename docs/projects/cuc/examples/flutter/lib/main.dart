import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final authorizationEndpoint =
    Uri.parse('https://cuenta.digital.gob.do/oauth2/auth');
final tokenEndpoint = Uri.parse('https://cuenta.digital.gob.do/oauth2/token');
final identifier = dotenv.env['CLIENT_ID']!;
final secret = dotenv.env['CLIENT_SECRET'];
final redirectUrl = Uri.parse(dotenv.env['REDIRECT_URL']!);

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
  //
  // `redirect` and `listen` are not shown implemented here. See below for the
  // details.
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

Future main() async {
  await dotenv.load(fileName: ".env");
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("img/logo-cuenta-unica.svg"),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'Prueba iniciar sesión con tu Cuenta Única, presionando el botón de abajo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF003876),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(
                    child: const Text("Iniciar sesión"),
                    onPressed: () async {
                      var client = await createClient();
                      inspect(client);
                      inspect(client.credentials);

                      var headers = {
                        'Authorization':
                            'Bearer ${client.credentials.accessToken}',
                      };

                      final response = await http.get(
                          Uri.parse('https://cuenta.digital.gob.do/userinfo'),
                          headers: headers);

                      if (response.statusCode == 200) {
                        print(response.body);
                        setState(() {
                          name = jsonDecode(response.body)["given_name"];
                        });
                      } else {
                        print(response.reasonPhrase);
                      }
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF003876))),
                Text(name)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
