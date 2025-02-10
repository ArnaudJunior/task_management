import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/models/user_cnx_details.dart';


class GeneralManagerDB {
  static final GeneralManagerDB _instance = GeneralManagerDB._internal();
  static SharedPreferences? prefs;

  // Constructeur privé pour empêcher les autres d'instancier la classe
  GeneralManagerDB._internal();

  // Fonction pour obtenir l'instance de la classe (singleton)
  factory GeneralManagerDB() {
    return _instance;
  }

  // Fonction pour initialiser les préférences partagées
  static Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Fonction pour sauvegarder la dernière route visitée
  static Future<void> saveLastRoute(String route) async {
    print("Sauvegarde de la route: $route");
    await prefs?.setString('lastRoute', route);
  }

  // Fonction pour récupérer la dernière route visitée
  static Future<String?> getLastRoute() async {
    final String? route = prefs?.getString('lastRoute');
    print("Route récupérée: $route");
    return route;
  }

    // Fonction pour sauvegarder la dernière route visitée
  static Future<void> saveSessionUser(String session) async {
    await prefs?.setString('USER_SESSION', session);
  }

  // Fonction pour récupérer la dernière route visitée
  static Future<String?> getSessionUser() async {
    final String? session = prefs?.getString('USER_SESSION');
    return session;
  }



  // Fonction pour sauvegarder les détails de l'utilisateur
  static Future<void> saveUserDetails(UserDetails userDetails) async {
    String jsonString = json.encode({
      'id': userDetails.id,
      'username': userDetails.username,
      'roles': userDetails.roles,
      'email': userDetails.email,
      'typeCompte': userDetails.typeCompte,
      'profil': {
        'id': userDetails.profile.id,
        'nom': userDetails.profile.nom,
        'prenom': userDetails.profile.prenom,
        'telephone': userDetails.profile.telephone,
        'addresse': userDetails.profile.addresse,
        'created_at': userDetails.profile.createdAt.toIso8601String(),
        'logo': userDetails.profile.logo,
        'is_completed': userDetails.profile.isCompleted,
      },
      'created_at': userDetails.createdAt.toIso8601String(),
      'isDeleted': userDetails.isDeleted,
      'status': userDetails.status,
    });
    await prefs?.setString('userDetails', jsonString);
    print("Détails de l'utilisateur sauvegardés: $jsonString");
  }

  // Fonction pour récupérer les détails de l'utilisateur
  static Future<UserDetails?> getUserDetails() async {
    final String? jsonString = prefs?.getString('userDetails');
    if (jsonString == null) return null;

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    UserDetails userDetails = UserDetails.fromJson(jsonMap);
    print("Détails de l'utilisateur récupérés: $jsonMap");
    return userDetails;
  }

  // Fonction pour supprimer les détails de l'utilisateur
  static Future<void> deleteUserDetails() async {
    await prefs?.remove('userDetails');
    print("Détails de l'utilisateur supprimés");
  }

  
}
