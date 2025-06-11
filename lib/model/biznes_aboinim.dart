class AbonimiModel{
  int? id;
  int? unike_id;
  String? dataAbonimit;
  String? skadimit;
  String? statusi;
  String? qmimi;
  String? puntoriAktiv;
  String? muaji;
  String? viti;


  AbonimiModel({this.id,this.unike_id,this.dataAbonimit,this.skadimit,this.statusi,this.qmimi,this.puntoriAktiv,this.muaji,this.viti});


  factory AbonimiModel.fromJson(Map<String,dynamic>json){
    return AbonimiModel(
      id: int.parse(json['id_abonimi']),
      unike_id: int.parse(json['unike_id']),
      dataAbonimit: json['dataAbonimit'],
      skadimit: json['skadimi'],
      statusi: json['statusi'],
      qmimi: json['qmimi'],
      puntoriAktiv: json['puntoriAktiv'],
      muaji: json['muaji'],
      viti: json['viti'],
    );

  }


  Map<String,dynamic> toJson()=>{
    'id_abonimi': id.toString(),
    'unike_id' : unike_id.toString(),
    'dataAbonimit':dataAbonimit,
    'skadimi' : skadimit,
    'statusi' : statusi,
    'qmimi' : qmimi,
    'puntoriAktiv':puntoriAktiv,
    'muaji':muaji,
    'viti':viti
  };




}