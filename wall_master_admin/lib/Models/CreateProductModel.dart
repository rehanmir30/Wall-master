
import 'dart:io';

class CreateProductModel{
  var id;
  List<String>? name;
  var category_id;
  List<File>? image;
  var for_premium;
  List<String> tags;

  CreateProductModel(this.id,{this.name, this.category_id, this.image, this.for_premium, required this.tags});

}