
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';


class DireccionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Estando dentro de Build se debe omitir el listen en el provider
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_ , i) => ListTile(
        leading: Icon(Icons.home, color: Theme.of(context).primaryColor ) ,
        title: Text(scans[i].valor),
        subtitle: Text(scans[i].id.toString()),
        trailing: Icon(Icons.keyboard_arrow_right, color:  Colors.grey,),
        onTap: () =>  print('Abrir algo. ${scans[i].id}'),
      )
    );
  }
}