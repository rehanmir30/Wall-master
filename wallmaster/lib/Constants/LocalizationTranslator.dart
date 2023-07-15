import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocalizationTranslator extends Translations{

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    //ENGLISH LANGUAGE
    'en_US':{
      //AppName
      "WallMaster": "Wall Master",

      //Social Login
      "ContinueWithGoogle": "Continue with Google",


      //OnBoardingScreen
      "Privacy": "PRIVACY",
      "Signin": "SIGN IN",
      "FAQ's": "FAQ's",
      "Help": "Help",
      "ForgetPassword": "Forget Password",
      "UnlimitedWallpapers": "Unlimited wallpapers",
      "DownloadTheWallpaperThatFitsYouBest.": "Download the wallpaper that fits you best.",
      "DownloadFreeWallpapers": "Download Free wallpapers",
      "AlwaysHaveSomethingToWatchOffline.": "Always have something to watch\noffline.",
      "GETSTARTED": "GET STARTED",

      //Sign Up Screen
      "Name": "Name",
      "Email": "Email",
      "Password": "Password",
      "ConfirmPassword": "Confirm Password",
      "SignUp": "Sign Up",
      "PasswordDoesNotMatch": "Password doesn't match",
      "PleaseFillAllTheFiled": "Please fill all the filed",


      //Sign In Screen
      "signin": "Sign In",
      "NeedHelp": "Need help",
      "NewSignUpNow": "New to wall Master? Sign up now",
      "Recaptchas": "Sign in is protected by Google reCAPTCHA to ensure you're not a bot.",

      //HomeScreen
      "Categories": "CATEGORIES",
      "Recent": "RECENT",
      "Premium": "PREMIUM",

      //Drawer
      "ChangeLanguage": "Change Language",
      "BuyPremium": "Buy Premium",
      "LikedWallpaper": "Liked Wallpaper",
      "Notifications": "Notifications",
      "PrivacyPolicy": "Privacy Policy",
      "Logout": "Log out",

      //Search Screen
      "Search": "Search",
      "NoWallpaperAvailable": "No wallpaper available",

      //RelatedCategoryScreen

      //SetWallpaperScreen
      "NoRelatedWallpaper": "No related wallpaper",
      "SetWallpaper": "Set Wallpaper",
      "LockScreen": "Lock Screen",
      "HomeScreen": "Home Screen",
      "Both": "Both",


      //EditWallpaperScreen
      "ImageFilters": "Image Filters",
      "WallpaperUpdatedSuccessfully":"Wallpaper Updated Successfully",
      "WallpaperUpdateFailed":"Wallpaper Update failed",
      "WallpaperDownloadedSuccessfully":"Wallpaper downloaded Successfully",
      "WallpaperDownloadFailed":"Wallpaper download Failed",


      //PrivacyPolicyScreen
      "PrivacyPolicy" : "Privacy Policy",
      "WallMasterPrivacyPolicy": 'WallMaster Privacy Policy',
      "ThisPrivacyPolicy": 'This Privacy Policy was last updated on July 13, 2023.',
      "GWebSoft": 'GWebSoft ("we", "us", "our") operates the WallMaster mobile application ("the Service").',
      "Thispageinformsyouofourpolicies": 'This page informs you of our policies regarding the collection, use and disclosure of Personal Data when you use our Service.',
      "ByusingtheService": 'By using the Service, you agree to the collection and use of information in accordance with this policy.',
      "InformationCollectionandUse": "Information Collection and Use",
      "ToprovideandimproveourService":"To provide and improve our Service, we may require you to provide us with certain personally identifiable information. The information we collect is used to provide the Service and maintain it, to notify you about changes to our Service, to allow you to participate in interactive features of our Service when you choose to do so, to provide customer support and to gather analysis or valuable information so that we can improve the Service.",
      "UsageData" : "Usage Data",
      "WhenyouaccesstheService" : "When you access the Service by a mobile device, we may collect certain data automatically, including, but not limited to, the type of mobile device you use, your mobile device's unique device ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browser you use, and other diagnostic data.",
      "CookiesandUsageData" : "Cookies and Usage Data",
      "Weusecookies" : "We use cookies and similar tracking technologies to track activity on our Service and store certain information.",
      "DataTransfer" : "Data Transfer",
      "Yourinformation": "Your information, including Personal Data, may be transferred to — and maintained on — computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from your jurisdiction.",
      "DataDisclosure": "Data Disclosure",
      "Wemaydisclose" : "We may disclose your Personal Data in good faith understanding that such action is necessary to:",

      "ComplyWith": "Comply with a legal obligation",
      "Protectanddefend" : "Protect and defend the rights or property of GWebSoft",
      "Preventorinvestigate" : "Prevent or investigate possible wrongdoing in connection with the Service",
      "Protectthepersonal" : "Protect the personal safety of users of the Service or the public",
      "ProtectAgainst" : "Protect against legal liability",
      "DataSecurity" : "Data Security",

      "Thesecurityofyourdata" : "The security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.",
      "LinkstoOtherSites" : "Links to Other Sites",
      "OurService" : "Our Service may contain links to other sites that are not operated by us. If you click on a third-party link, you will be directed to that third party's site. We strongly advise you to review the Privacy Policy of every site you visit.",
      "ChangestoThisPrivacyPolicy" : "Changes to This Privacy Policy",
      "" : "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.",
      "Contact" : "Contact",
      "pleasecontactus" : "If you have any questions about this Privacy Policy, please contact us:",
      "email": "admin@gwebsoft.org",


      //Buy Premium Package Screen
      "Upgrade" : "Upgrade to our Premium Package and enjoy exclusive benefits that will elevate your wallpaper app experience. With unlimited access to a diverse library of high-quality wallpapers, you can easily personalize your device with stunning images that match your style and mood. Say goodbye to interruptions with our ad-free environment, allowing you to browse seamlessly and focus on discovering the perfect wallpapers. Plus, with an increased wallpaper limit, you can expand your collection and effortlessly switch between favorites. Gain early access to new releases and exclusive collections, staying ahead of trends and accessing unique wallpapers. Enjoy priority customer support, ensuring a smooth experience throughout your subscription. Upgrade today and unlock a world of possibilities for your wallpaper app journey!",
      "provide" : "What we provide:",
      "RemoveAds" : "Remove Ads",
      "LiveUpdates" : "Live Updates",
      "UnlimitedWallpapers" : "Unlimited Wallpapers",
      "OneYear" : "Get our premium package for a full year of exclusive benefits. Elevate your wallpaper app experience now only in \$6.99!",
      "Iagreeto" : "I agree to ",
      "termsandconditions" : "terms and conditions",

      //Buy Premium Dialog
      "premiummember" : "You are not a premium member",
      "viewwallpaper" : "If you want to view wallpaper",
      "ViewAd" : "View Ad",
      "BuyPremium" : "Buy Premium",




      // Terms And Condtions
      "WallMasterTermsandConditions" : "WallMaster Terms and Conditions",

      "AcceptanceofTerms" : "Acceptance of Terms",
      "ByAccessing" : "By accessing and using the WallMaster application ('the Application') operated by GWebSoft ('us', 'our'), you accept and agree to these Terms and Conditions.",

      "Services" : "Services",
      "WeProvide" : "We provide an application that offers a diverse library of high-quality wallpapers. You are responsible for all activities that occur under your account and must handle any access code or password confidentially.",

      "Privacy" : "Privacy",
      "PleaseRefer" : "Please refer to our Privacy Policy which explains how we collect, use, and disclose the information you provide to us.",

      "UseLimitations" : "Use Limitations",
      "YouAgree" : "You agree not to use the Application in a way that causes, or may cause, damage to the Application or impediment of the access or use of the Application. You must not use the Application in an illegal, fraudulent, or harmful way.",

      "IntellectualProperty" : "Intellectual Property",
      "Allintellectual" : "All intellectual property rights in and on the Application and its content are owned by us or our licensors. You have no right to copy, distribute, modify, reverse engineer, disassemble, attempt to derive the source code of, or create derivative works from the Application.",

      "Changes" : "Changes",
      "WeReserve" : "We reserve the right to change these Terms and Conditions at any time. By continuing to use the Application after such changes are made, you accept the revised terms.",

      "Termination" : "Termination",
      "Wemayterminate" : "We may terminate or suspend your access to the Application at any time, without prior notice or liability, for any reason.",

      "ApplicableLaw" : "Applicable Law",
      "Thesetermsandconditions" : "These terms and conditions will be governed and interpreted in accordance with the laws of [your location] and you submit to the non-exclusive jurisdiction of the state and federal courts located in [your location] for the resolution of any disputes.",

      "Contact" : "Contact",
      "Ifyouhave" : "If you have any questions about these Terms and Conditions, please contact us: ",

      "email" : "admin@gwebsoft.org",


      //FAQS Screen

      "FAQ" : "FAQS",

      "PremiumWallpaper" : "What is a Premium Wallpaper? ",
      "PremiumWallpaperDescription" : "Premium wallpapers are exclusive wallpapers only available to Premium users or those who choose to watch a Google ad to unlock them. These wallpapers are unique and of higher quality compared to our free wallpapers.",

      "PremiumUser" : "Premium User? ",
      "PremiumUserDescription" : "You can become a premium user by subscribing to our Premium Plan within the app. The premium subscription offers benefits like ad-free browsing, instant access to premium wallpapers, and more.",

      "PremiumPlan" : "What if I don't want to subscribe to the Premium Plan? ",
      "PremiumPlanDescription" : "You can still access our premium wallpapers by choosing to watch a Google ad. After watching the ad, the premium wallpaper will be unlocked for your use.",

      "WallPaperUse" : "Can I use the wallpapers for both my lock screen and home screen? ",
      "WallPaperUseDescription" : "Yes, you can set any of our wallpapers for both your lock screen and home screen according to your preference.",

      "HowtoDownloadWalllaper" : "Do I need to watch an ad for every premium wallpaper I want to download? ",
      "HowtoDownloadWalllaperDescription" :"Yes, if you are not a Premium user, you will need to watch an ad to unlock each premium wallpaper you wish to use.",

      "PremiumWallpaperRemains" : "Will my unlocked premium wallpapers remain available if I uninstall the app or switch devices? ",
      "PremiumWallpaperRemainsDescription" : "No, if you are not a Premium user, the wallpapers unlocked by watching ads will not remain available if you uninstall the app or switch devices. However, if you are a Premium user, your access to these wallpapers will be saved with your account, and you can access them across any devices.",

      "PremiumSeeingAd" : "I am a Premium User. Why am I still seeing ads? ",
      "PremiumSeeingAdDescription" : "As a Premium user, you should not see any ads within the app. If you're encountering ads, please ensure that your subscription is active, and try logging out and back into your account. If the issue persists, please contact our support team.",

      "CannotWatchWallpaperAfterAd" : "I have watched an ad but the Premium wallpaper is not unlocked. What should I do? ",
      "CannotWatchWallpaperAfterAdDescription" : "Please ensure you have a stable internet connection and try restarting the app. If the issue persists, please contact our support team.",

      "CanShareWallpapers" : "Can I share the wallpapers with others? ",
      "CanShareWallpapersDescription" : "Our terms and conditions do not allow sharing of wallpapers, either free or premium, outside of our app. We encourage all users to respect the work of the artists who create these wallpapers.",

      "HowToShareWallpaper" : "I have a suggestion for a wallpaper, how can I share it? ",
      "HowToShareWallpaperDescription" : "We love to hear from our users! Please use the feedback function within the app to share your suggestions.",

      "DownloadLimits" : "Is there any limit to the number of wallpapers I can download in a day? ",
      "DownloadLimitsDescription" : "No, there is no limit on the number of wallpapers you can download in a day, whether you are a free user or a Premium user.",


      //HelpScreen
      "Helped" : "HELP",
      "HowToDownloadWallpaper" : "How to Download a Wallpaper: ",
      "HowToDownloadWallpaperDescription" : "To download a wallpaper, navigate to the wallpaper you want to download and click on the 'Download' button. If it's a Premium wallpaper, you'll need to watch an ad or be a Premium user to download it.",

      "HowToSetWallpaper" : "How to Set a Wallpaper: ",
      "HowToSetWallpaperDescription" : "Once you've downloaded the wallpaper, navigate to your device's wallpaper settings. Choose 'Lock Screen', 'Home Screen', or 'Both', then select the downloaded wallpaper from your photo gallery.",

      "HowToBecomePremium" : "How to Become a Premium User: ",
      "HowToBecomePremiumDescription" : "To become a Premium user, go to the 'Settings' tab in the app, then click on 'Go Premium'. Follow the prompts to complete your subscription.",

      "HowToUseAppWithoutSubscription" : "How to Use the App Without a Subscription: ",
      "HowToUseAppWithoutSubscriptionDescription" : "If you don't want to become a Premium user, you can still enjoy our wallpapers. For premium wallpapers, you'll need to watch an ad to unlock each one you want to use.",

      "HowToContactSupport" : "How to Contact Support: ",
      "HowToContactSupportDescription" : "If you need help or have any questions about the app, you can contact us here: ",
      'email': "admin@gwebsoft.org",



    },

    //Spanish LANGUAGE
    'es_US':{
      //AppName
      "WallMaster": "Wall Master",

      //Social Login
      "ContinueWithGoogle": "Continuar con Google",

      //OnBoardingScreen
      "Privacy": "PRIVACIDAD",
      "Signin": "INICIAR SESIÓN",
      "FAQ's": "Preguntas frecuentes",
      "Help": "Ayuda",
      "ForgetPassword": "Contraseña olvidada",
      "UnlimitedWallpapers": "Fondos de pantalla ilimitados",
      "DownloadTheWallpaperThatFitsYouBest.": "Descarga el fondo de pantalla que mejor se adapte a ti.",
      "DownloadFreeWallpapers": "Descargar fondos de pantalla gratis",
      "AlwaysHaveSomethingToWatchOffline.": "Siempre ten algo para ver\nsin conexión.",
      "GETSTARTED": "EMPEZAR",

      //Sign Up Screen
      "Name": "Nombre",
      "Email": "Correo electrónico",
      "Password": "Contraseña",
      "ConfirmPassword": "confirmar Contraseña",
      "SignUp": "Inscribirse",
      "PasswordDoesNotMatch": "La contraseña no coincide",
      "PleaseFillAllTheFiled": "Por favor complete todos los campos",

      //Sign In Screen
      "signin": "Iniciar sesión",
      "NeedHelp": "Necesitas ayuda",
      "NewSignUpNow": "¿Nuevo en Wall Master? Regístrate ahora",
      "Recaptchas": "El inicio de sesión está protegido por Google reCAPTCHA para garantizar que no sea un bot.",

      //HomeScreen
      "Categories": "CATEGORIAS",
      "Recent": "RECIENTE",
      "Premium": "PREMIUM",


      //Drawer
      "ChangeLanguage": "Cambiar idioma",
      "BuyPremium": "Comprar Premium",
      "LikedWallpaper": "Fondo de pantalla que me gustó",
      "Notifications": "Notificaciones",
      "PrivacyPolicy": "política de privacidad",
      "Logout": "Cerrar sesión",

      //Search Screen
      "Search": "Buscar",
      "NoWallpaperAvailable": "No hay fondo de pantalla disponible",

      //RelatedCategoryScreen

      //SetWallpaperScreen
      "NoRelatedWallpaper": "Sin fondo de pantalla relacionado",
      "SetWallpaper": "Establecer fondo de pantalla",
      "LockScreen": "Pantalla de Bloqueo",
      "HomeScreen": "Pantalla de inicio",
      "Both": "Ambas",


      //EditWallpaperScreen
      "ImageFilters": "Filtros de imagen",
      "WallpaperUpdatedSuccessfully":"Fondo de pantalla actualizado con éxito",
      "WallpaperUpdateFailed":"Actualización de fondo de pantalla fallida",
      "WallpaperDownloadedSuccessfully":"Fondo de pantalla descargado con éxito",
      "WallpaperDownloadFailed":"Descarga de fondo de pantalla fallida",


      //PrivacyPolicyScreen
      "PrivacyPolicy" : "política de privacidad",
      "WallMasterPrivacyPolicy": 'Política de Privacidad de WallMaster',
      "ThisPrivacyPolicy": 'Esta Política de Privacidad fue actualizada por última vez el 13 de Julio de 2023.',
      "GWebSoft": 'GWebSoft ("nosotros", "nos", "nuestro") opera la aplicación móvil WallMaster ("el Servicio").',
      "Thispageinformsyouofourpolicies": 'Esta página le informa de nuestras políticas en relación con la recopilación, uso y divulgación de Datos Personales cuando usted utiliza nuestro Servicio.',
      "ByusingtheService": 'Al utilizar el Servicio, usted acepta la recopilación y el uso de la información de acuerdo con esta política.',
      "InformationCollectionandUse": "Recopilación y Uso de Información",
      "ToprovideandimproveourService":"Para proporcionar y mejorar nuestro Servicio, podemos requerir que nos proporcione cierta información de identificación personal. La información que recopilamos se utiliza para proporcionar el Servicio y mantenerlo, para notificarle sobre cambios en nuestro Servicio, para permitirle participar en funciones interactivas de nuestro Servicio cuando elija hacerlo, para proporcionar asistencia al cliente y para recoger análisis o información valiosa para que podamos mejorar el Servicio.",
      "UsageData" : "Datos de Uso",
      "WhenyouaccesstheService" : "Cuando accede al Servicio mediante un dispositivo móvil, podemos recopilar ciertos datos automáticamente, incluyendo, entre otros, el tipo de dispositivo móvil que utiliza, la identificación única de su dispositivo móvil, la dirección IP de su dispositivo móvil, su sistema operativo móvil, el tipo de navegador de Internet móvil que utiliza, y otros datos de diagnóstico.",
      "CookiesandUsageData" : "Cookies y Datos de Uso",
      "Weusecookies" : "Utilizamos cookies y tecnologías de seguimiento similares para rastrear la actividad en nuestro Servicio y almacenar cierta información.",
      "DataTransfer" : "Transferencia de Datos",
      "Yourinformation": "Sus datos, incluyendo Datos Personales, pueden ser transferidos a —y mantenidos en— computadoras ubicadas fuera de su estado, provincia, país u otra jurisdicción gubernamental donde las leyes de protección de datos pueden diferir a las de su jurisdicción.",
      "DataDisclosure": "Divulgación de Datos",
      "Wemaydisclose" : "Podemos divulgar sus Datos Personales de buena fe entendiendo que tal acción es necesaria para:",
      "ComplyWith": "Cumplir con una obligación legal",
      "Protectanddefend" : "Proteger y defender los derechos o propiedad de GWebSoft",
      "Preventorinvestigate" : "Prevenir o investigar posibles irregularidades en relación con el Servicio",
      "Protectthepersonal" : "Proteger la seguridad personal de los usuarios del Servicio o del público",
      "ProtectAgainst" : "Proteger contra responsabilidad legal",
      "DataSecurity" : "Seguridad de los Datos",
      "Thesecurityofyourdata" : "La seguridad de sus datos es importante para nosotros, pero recuerde que ningún método de transmisión por Internet, o método de almacenamiento electrónico es 100% seguro. Aunque nos esforzamos por usar medios comercialmente aceptables para proteger sus Datos Personales, no podemos garantizar su seguridad absoluta.",
      "LinkstoOtherSites" : "Enlaces a Otros Sitios",
      "OurService" : "Nuestro Servicio puede contener enlaces a otros sitios que no son operados por nosotros. Si hace clic en un enlace de terceros, será dirigido al sitio de ese tercero. Le recomendamos que revise la Política de Privacidad de cada sitio que visite.",
      "ChangestoThisPrivacyPolicy" : "Cambios en Esta Política de Privacidad",
      "Wemayupdate" : "Podemos actualizar nuestra Política de Privacidad de vez en cuando. Le notificaremos de cualquier cambio publicando la nueva Política de Privacidad en esta página.",
      "Contact" : "Contacto",
      "pleasecontactus" : "Si tiene alguna pregunta sobre esta Política de Privacidad, contáctenos: ",
      "email": "admin@gwebsoft.org",


      //Buy Premium Package Screen
      "Upgrade" : "Actualice a nuestro Paquete Premium y disfrute de beneficios exclusivos que elevarán su experiencia con la aplicación de fondos de pantalla. Con acceso ilimitado a una biblioteca diversa de fondos de pantalla de alta calidad, puede personalizar fácilmente su dispositivo con imágenes impresionantes que coincidan con su estilo y estado de ánimo. Di adiós a las interrupciones con nuestro entorno sin publicidad, que te permite navegar sin problemas y concentrarte en descubrir los fondos de pantalla perfectos. Además, con un mayor límite de fondos de pantalla, puede ampliar su colección y cambiar sin esfuerzo entre sus favoritos. Obtenga acceso anticipado a nuevos lanzamientos y colecciones exclusivas, adelántese a las tendencias y acceda a fondos de pantalla únicos. Disfrute de atención al cliente prioritaria, lo que garantiza una experiencia fluida a lo largo de su suscripción. ¡Actualice hoy y desbloquee un mundo de posibilidades para su viaje a la aplicación de fondos de pantalla!",
      "provide" : "Lo que proporcionamos:",
      "RemoveAds" : "Quitar anuncios",
      "LiveUpdates" : "Actualizaciones en vivo",
      "UnlimitedWallpapers" : "Fondos de pantalla ilimitados",
      "OneYear" : "Obtenga nuestro paquete premium por un año completo de beneficios exclusivos. ¡Mejora tu experiencia con la aplicación de fondo de pantalla ahora solo en \$6.99!",
      "Iagreeto" : "Acepto los ",
      "termsandconditions" : "términos y condiciones",

      //Buy Premium Dialog
      "premiummember" : "No eres miembro premium",
      "viewwallpaper" : "Si quieres ver el fondo de pantalla",
      "ViewAd" : "Ver anuncio",
      "BuyPremium" : "Comprar Premium",


      // Terms And Condtions
      "WallMasterTermsandConditions" : "Términos y Condiciones de WallMaster",

      "AcceptanceofTerms" : "Aceptación de los Términos",
      "ByAccessing" : "Al acceder y utilizar la aplicación WallMaster ('la Aplicación') operada por GWebSoft ('nosotros', 'nuestro'), usted acepta y está de acuerdo con estos Términos y Condiciones.",

      "Services" : "Servicios",
      "WeProvide" : "Proporcionamos una aplicación que ofrece una diversa biblioteca de fondos de pantalla de alta calidad. Usted es responsable de todas las actividades que ocurren bajo su cuenta y debe manejar cualquier código de acceso o contraseña con confidencialidad.",

      "Privacy" : "Privacidad",
      "PleaseRefer" : "Por favor, consulte nuestra Política de Privacidad que explica cómo recopilamos, usamos y divulgamos la información que usted nos proporciona.",

      "UseLimitations" : "Limitaciones de Uso",
      "YouAgree" : "Usted se compromete a no utilizar la Aplicación de manera que cause, o pueda causar, daño a la Aplicación o impedimento del acceso o uso de la Aplicación. No debe usar la Aplicación de manera ilegal, fraudulenta o dañina.",

      "IntellectualProperty" : "Propiedad Intelectualy",
      "Allintellectual" : "Todos los derechos de propiedad intelectual en y sobre la Aplicación y su contenido son propiedad de nosotros o de nuestros licenciantes. Usted no tiene derecho a copiar, distribuir, modificar, realizar ingeniería inversa, desmontar, intentar derivar el código fuente de, o crear obras derivadas de la Aplicación.",

      "Changes" : "Cambios",
      "WeReserve" : "Nos reservamos el derecho de cambiar estos Términos y Condiciones en cualquier momento. Al continuar utilizando la Aplicación después de que se realicen esos cambios, usted acepta los términos revisados.",

      "Termination" : "Terminación",
      "Wemayterminate" : "Podemos terminar o suspender su acceso a la Aplicación en cualquier momento, sin previo aviso ni responsabilidad, por cualquier motivo.",

      "ApplicableLaw" : "Ley Aplicable",
      "Thesetermsandconditions" : "Estos términos y condiciones se regirán e interpretarán de acuerdo con las leyes de [su ubicación] y usted se somete a la jurisdicción no exclusiva de los tribunales estatales y federales ubicados en [su ubicación] para la resolución de cualquier disputa.",

      "Contact" : "Contacto",
      "Ifyouhave" : "Si tiene alguna pregunta sobre estos Términos y Condiciones, contáctenos: ",

      "email" : "admin@gwebsoft.org",



      //FAQS Screen
      "FAQ" : "PREGUNTAS Y RESPUESTAS",
      "PremiumWallpaper" : "¿Qué es un Wallpaper Premium? ",
      "PremiumWallpaperDescription" : "Los wallpapers premium son fondos de pantalla exclusivos disponibles solo para usuarios Premium o aquellos que eligen ver un anuncio de Google para desbloquearlos. Estos wallpapers son únicos y de mayor calidad en comparación con nuestros wallpapers gratuitos.",

      "PremiumUser" : "¿Cómo puedo convertirme en un Usuario Premium? ",
      "PremiumUserDescription" : "Puedes convertirte en un usuario Premium suscribiéndote a nuestro Plan Premium dentro de la aplicación. La suscripción premium ofrece beneficios como navegación sin anuncios, acceso instantáneo a wallpapers premium y más.",

      "PremiumPlan" : "¿Qué pasa si no quiero suscribirme al Plan Premium? ",
      "PremiumPlanDescription" : "Aún puedes acceder a nuestros wallpapers premium eligiendo ver un anuncio de Google. Después de ver el anuncio, el wallpaper premium se desbloqueará para su uso.",

      "WallPaperUse" : "¿Puedo usar los wallpapers para mi pantalla de bloqueo y pantalla de inicio? ",
      "WallPaperUseDescription" : "Sí, puedes configurar cualquiera de nuestros wallpapers para tu pantalla de bloqueo y pantalla de inicio según tu preferencia.",

      "HowtoDownloadWalllaper" : "¿Necesito ver un anuncio para cada wallpaper premium que quiera descargar? ",
      "HowtoDownloadWalllaperDescription" :"Sí, si no eres un usuario Premium, tendrás que ver un anuncio para desbloquear cada wallpaper premium que desees usar.",

      "PremiumWallpaperRemains" : "¿Mis wallpapers premium desbloqueados permanecerán disponibles si desinstalo la aplicación o cambio de dispositivo? ",
      "PremiumWallpaperRemainsDescription" : "No, si no eres un usuario Premium, los wallpapers desbloqueados al ver anuncios no permanecerán disponibles si desinstalas la aplicación o cambias de dispositivo. Sin embargo, si eres un usuario Premium, tu acceso a estos wallpapers se guardará con tu cuenta y puedes acceder a ellos desde cualquier dispositivo.",

      "PremiumSeeingAd" : "Soy un Usuario Premium. ¿Por qué sigo viendo anuncios? ",
      "PremiumSeeingAdDescription" : "Como usuario Premium, no deberías ver ningún anuncio dentro de la aplicación. Si encuentras anuncios, por favor asegúrate de que tu suscripción está activa e intenta cerrar sesión y volver a iniciarla. Si el problema persiste, por favor contacta a nuestro equipo de soporte.",

      "CannotWatchWallpaperAfterAd" : "He visto un anuncio pero el Wallpaper Premium no se ha desbloqueado. ¿Qué debo hacer? ",
      "CannotWatchWallpaperAfterAdDescription" : "Por favor asegúrate de tener una conexión a internet estable e intenta reiniciar la aplicación. Si el problema persiste, por favor contacta a nuestro equipo de soporte.",

      "CanShareWallpapers" : "¿Puedo compartir los wallpapers con otros? ",
      "CanShareWallpapersDescription" : "Nuestros términos y condiciones no permiten compartir wallpapers, gratuitos o premium, fuera de nuestra aplicación. Animamos a todos los usuarios a respetar el trabajo de los artistas que crean estos wallpapers.",

      "HowToShareWallpaper" : "Tengo una sugerencia para un wallpaper, ¿cómo puedo compartirla? ",
      "HowToShareWallpaperDescription" : "¡Nos encanta escuchar a nuestros usuarios! Por favor utiliza la función de feedback dentro de la aplicación para compartir tus sugerencias.",

      "DownloadLimits" : "¿Existe algún límite en el número de wallpapers que puedo descargar en un día? ",
      "DownloadLimitsDescription" : "No, no hay límite en el número de wallpapers que puedes descargar en un día, ya seas un usuario gratuito o un usuario Premium.",


      //HelpScreen
      "Helped" : "AYUDA",
      "HowToDownloadWallpaper" : "Cómo descargar un Wallpaper: ",
      "HowToDownloadWallpaperDescription" : "Para descargar un wallpaper, navega hasta el wallpaper que deseas descargar y haz clic en el botón 'Descargar'. Si es un wallpaper premium, necesitarás ver un anuncio o ser un usuario premium para poder descargarlo.",

      "HowToSetWallpaper" : "Cómo configurar un Wallpaper: ",
      "HowToSetWallpaperDescription" : "Una vez que hayas descargado el wallpaper, ve a los ajustes de wallpaper de tu dispositivo. Elige 'Pantalla de bloqueo', 'Pantalla de inicio' o 'Ambas', luego selecciona el wallpaper descargado desde tu galería de fotos.",

      "HowToBecomePremium" : "⦁	Cómo convertirse en un Usuario Premium: ",
      "HowToBecomePremiumDescription" : "Para convertirte en un usuario premium, ve a la pestaña 'Configuración' en la aplicación, luego haz clic en 'Hacerse Premium'. Sigue las instrucciones para completar tu suscripción.",

      "HowToUseAppWithoutSubscription" : "Cómo usar la aplicación sin una suscripción:",
      "HowToUseAppWithoutSubscriptionDescription" : "Si no deseas convertirte en un usuario premium, aún puedes disfrutar de nuestros wallpapers. Para los wallpapers premium, tendrás que ver un anuncio para desbloquear cada uno que quieras usar.",

      "HowToContactSupport" : "Cómo contactar al Soporte: ",
      "HowToContactSupportDescription" : "Si necesitas ayuda o tienes alguna pregunta sobre la aplicación, puedes contactar a nuestro equipo de soporte escribiéndonos a ",

      'email': "admin@gwebsoft.org",




    },

  };




}