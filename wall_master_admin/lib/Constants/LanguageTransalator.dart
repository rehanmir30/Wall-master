import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageTransalator extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {


    // For English Language
    'en_US':{
      //AppName
      "AppName": "Wall Master",
      //LoginScreen
      "AdminAccount": "Admin Account",
      "Email":"Email",
      "Password":"Password",
      "Sigin": "Sign In",

      //HomeScreen
      "Categories": "Categories",
      "Users": "Users",
      "Profile": "Profile",
      "NoCategoryAvailable": "No category available",
      "AddCategory": "Add Category",

      //Add new Category Screen
      "AddNewCategory": "Add New Category",
      "CategoryName": "Category Name",
      "PleasePickImageAndFillAllFields": "Please pick image and fill all fields",
      "Create": "Create",

      //RelatedCategoryScreen
      "EditCategory": "Edit Category",
      "AddWallpaper": "Add Wallpaper",

      //EditCategoryScreen
      "Confirmation": "Confirmation",
      "AreYouSureYouWantToDeleteTheCategory": "Are you sure you want to delete the category?",
      "Cancel":"Cancel",
      "Delete":"Delete",
      "PleaseFillAllFields":"Please fill all fields",
      "Update":"Update",

      //Add New WallPaperScreen
      "TAG": "TAG",
      "EnterTag": "Enter Tag",
      "PickWallpapers": "ADD IMAGES +",
      "NoWallpaperSelected": "No Wallpaper selected",
      "Premium": "Premium",
      "TAGS": "TAGS",
      "Data": "Your Tags",
      "WallpaperImageAndTagsAreRequired": "Wallpaper Image and tags are required",
      "YouCannotPassAnEmptyTag": "You cannot pass an empty tag",
      "Upload":"Upload",

      //PreviewWallpaperScreen
      "WallpaperPreview": "Wallpaper Preview",
      "Edit": "Edit",
      "AreYouSureYouWantToDeleteTheProduct": "Are you sure you want to delete the product?",


      //All Users Screen
      "Search":"Search",
      "NoUserFound":"No User Found",
      "NoSearchedFound":"No searched found",

      //UserDetailScreen
      "Standard":"Standard",
      "Detail":"Detail",
      "Name": "Name",
      "Package": "Package",

      //Profile Screen
      "AdminProfile": "Admin Profile",
      "Logout": "Logout",
      "EditProfile": "Edit Profile",
      "SaveProfile": "Save Profile",



      //Common Message
      "NoWallpaperFound": "No wallpaper found",
    },

    //For Spanish Language

    'es_US':{
      //AppName
      "AppName": "Wall Master",
      //Login Screen
      "AdminAccount": "Cuenta de administrador",
      "Email":"Correo electrónico",
      "Password":"Contraseña",
      "Sigin": "Iniciar sesión",

      //HomeScreen
      "Categories": "Categorías",
      "Users": "Usuarias",
      "Profile": "Perfil",
      "NoCategoryAvailable": "Ninguna categoría disponible",
      "AddCategory": "añadir categoría",

      //Add New Category Screen
      "AddNewCategory": "Añadir nueva categoria",
      "CategoryName": "nombre de la categoría",
      "PleasePickImageAndFillAllFields": "Elija la imagen y complete todos los campos",
      "Create": "Crear",

      //RelatedCategoryScreen
      "EditCategory": "Editar categoria",
      "AddWallpaper": "Agregar fondo de pantalla",


      //EditCategoryScreen
      "Confirmation": "Confirmación",
      "AreYouSureYouWantToDeleteTheCategory": "¿Está seguro de que desea eliminar la categoría?",
      "Cancel":"Cancelar",
      "Delete":"Borrar",
      "PleaseFillAllFields":"Por favor llena todos los espacios",
      "Update": "Actualizar",

      //Add New WallPaperScreen
      "TAG": "ETIQUETA",
      "EnterTag": "Introducir etiqueta",
      "PickWallpapers": "AÑADIR IMÁGENES +",
      "NoWallpaperSelected": "Ningún fondo de pantalla seleccionado",
      "Premium": "De primera calidad",
      "TAGS": "ETIQUETAS",
      "Data": "Tus etiquetas",
      "WallpaperImageAndTagsAreRequired": "Se requiere imagen de fondo de pantalla y etiquetas",
      "YouCannotPassAnEmptyTag": "No puede pasar una etiqueta vacía",
      "Upload":"Subir",

      //PreviewWallpaperScreen
      "WallpaperPreview": "Vista previa del fondo de pantalla",
      "Edit": "Editar",
      "AreYouSureYouWantToDeleteTheProduct": "¿Está seguro de que desea eliminar el producto?",


      //All Users Screen
      "Search":"Buscar",
      "NoUserFound":"Usuario no encontrado",
      "NoSearchedFound":"No buscado encontrado",

      //UserDetailScreen
      "Standard":"Estándar",
      "Detail":"Detalle",
      "Name": "Nombre",
      "Package": "Paquete",

      //Profile Screen
      "AdminProfile": "Perfil de admin",
      "Logout": "Cerrar sesión",
      "EditProfile": "Editar perfil",
      "SaveProfile": "Guardar perfil",

      //Common Message
      "NoWallpaperFound": "No se encontró ningún fondo de pantalla",
    }

  };

}