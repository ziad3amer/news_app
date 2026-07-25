extension DataTimeFormater on DateTime{

  String formateDateTime(){
    final deff = DateTime.now().difference(this);
    if(deff.inMinutes < 60 )
    {
      return "${deff.inMinutes}m ago";
    }
    if(deff.inHours<24){
      return "${deff.inHours}h ago";
    }
    return "${deff.inDays}d ago";
  }


}