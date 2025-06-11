class BiznesModel{
  int? id;
  int? idUnike;
  String? nameBiz;
  String? dataregj;
  String? nrTel;
  String? qyteti;
  String? nrBiz;
  String? koment;
  String? statusi;
  String? puntoriAktiv;
  String? long;




  BiznesModel({this.id,this.nameBiz,this.dataregj,this.nrTel,this.qyteti,this.nrBiz,this.koment,this.statusi,this.puntoriAktiv,this.long,this.idUnike});

  factory BiznesModel.fromJson(Map<String,dynamic>json)=>BiznesModel(
    id: int.parse(json['id_biznesi']),
    nameBiz: json['nameBiz'],
    dataregj: json['dataRegjistrimit'],
    nrTel: json['nrTelefonit'],
    qyteti: json['qyteti'],
    nrBiz: json['nrBiznesit'],
    koment: json['koment'],
    statusi: json['statusi'],
    puntoriAktiv: json['puntoriAktiv'],
    long: json['longg'],
  );

Map<String,dynamic> toJson()=>
    {
      'id_biznesi':id.toString(),
      'nameBiz':nameBiz,
      'dataRegjistrimit':dataregj,
      'nrTelefonit':nrTel,
      'qyteti':qyteti,
      'nrBiznesit':nrBiz,
      'koment':koment,
      'statusi':statusi,
      'puntoriAktiv':puntoriAktiv,
      'longg':long,
      'unique_id':idUnike.toString()
    };












}