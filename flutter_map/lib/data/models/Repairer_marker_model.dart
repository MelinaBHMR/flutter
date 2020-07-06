

class RepairerModel {

  final String id;
  final String name;
  final String adress;
  final String phone;
  final String fax;
  final String mail;
  final String latitude;
  final String longitude;
  final String infos;

  RepairerModel(this.id, this.name, this.adress, this.phone, this.fax, this.mail, this.latitude, this.longitude, this.infos);

  factory RepairerModel.fromJson(Map<String, dynamic> parsedJson){
    return RepairerModel(
      parsedJson['idReparateur'],
      parsedJson['nomReparateur']+' '+parsedJson['complementReparateur'],
      parsedJson['adresse1Reparateur']+' '+parsedJson['adresse2Reparateur']+' '+parsedJson['adresse3Reparateur']+' '+parsedJson['codePostalReparateur']+' '+parsedJson['villeReparateur'],
      parsedJson['telephoneReparateur'],
      parsedJson['faxReparateur'],
      parsedJson['emailReparateur'],
      parsedJson['latitudeReparateur'],
      parsedJson['longitudeReparateur'],
      parsedJson['infosOuverture1']+' '+parsedJson['infosOuverture2']+' '+parsedJson['infosOuverture3']
    );
    }

}