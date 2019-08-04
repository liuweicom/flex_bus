class ListTileModal{
  String title;
  Object iconsData;
  ListTileModal({this.title, this.iconsData});
  factory ListTileModal.fromJson(Map<String, dynamic>json){
    return ListTileModal(
      title: json["title"],
        iconsData: json["iconsData"]
    );
  }
}