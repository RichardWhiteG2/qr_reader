
import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

//Para actualizar la UI de bd.

class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  //Se inserta un registro pero noa ctualiza ui
  nuevoScan(String valor) async{

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;
    if(this.tipoSeleccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async{
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async{
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }
  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }
  borrarScanPorId ( int id ) async {
    await DBProvider.db.deleteScan(id);
    //Se omite la siguiente linea ya que se tiene el Widget Dismissble en mapas_pages
    //this.cargarScansPorTipo(this.tipoSeleccionado);
    
  }


}