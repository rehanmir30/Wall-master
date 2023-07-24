
import 'dart:io';

class UpdateProductModel{
  var id;
  var name;
  var category_id;
  var image;
  var for_premium;
  List<dynamic> tags;

  UpdateProductModel(this.id,{this.name, this.category_id, this.image, this.for_premium, required this.tags});

}