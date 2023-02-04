import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';
 
launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
 
  if (scan.tipo == 'http') {
    //abrir el sitio web
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    print('geo!!');
    Navigator.pushNamed(context, 'mapa', arguments: scan );
  }
}