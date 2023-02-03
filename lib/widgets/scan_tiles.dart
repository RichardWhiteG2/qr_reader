import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  
  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    //Estando dentro de Build se debe omitir el listen en el provider
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      //Dismissible permite borrar.
      itemBuilder: (_ , i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed:(DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[i].id!);
        } ,
        child: ListTile(
          leading: Icon(
            this.tipo == 'http'
            ? Icons.home_outlined
            : Icons.map_outlined, 
            color: Theme.of(context).primaryColor ) ,
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color:  Colors.grey,),
          onTap: () =>  print('Abrir algo. ${scans[i].id}'),
        ),
      )
    );

  }
}