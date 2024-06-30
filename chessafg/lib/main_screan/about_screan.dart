import 'package:chessafg/provider/infomation/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  
  @override
  _AboutScreenState createState() => _AboutScreenState();
  
}

class _AboutScreenState extends State<AboutScreen> {
  
  final String appVersion = '1.0.0';
  

  // void _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  void _launchURL(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final String appDescription = themeProvider.language == 'English'
              ? "This mobile application project for the Afghanistan Chess National Team was developed as part of the requirements for the defense of Rahmatullah Ahmadi and Murtaza Yusufi's Bachelor degrees. The project showcases their technical skills, creativity, and dedication, serving as a comprehensive demonstration of their ability to design and implement a sophisticated mobile application. Their work not only fulfills academic requirements but also contributes significantly to the promotion and support of chess in Afghanistan."
              : themeProvider.language == 'فارسی'
                  ?"این پروژه اپلیکیشن موبایلی برای تیم ملی شطرنج افغانستان به عنوان بخشی از الزامات دفاع از مدرک لیسانس رحمت الله احمدی و مرتضی یوسفی توسعه یافته است. این پروژه مهارت های فنی، خلاقیت و فداکاری آنها را به نمایش می گذارد و به عنوان یک نمایش جامع از توانایی آنها عمل می کند. برای طراحی و پیاده سازی یک اپلیکیشن موبایل پیچیده، کار آنها نه تنها نیازمندی های آکادمیک را برآورده می کند، بلکه به ارتقا و حمایت از شطرنج در افغانستان کمک شایانی می کند"
                  : themeProvider.language == 'پشتو'
                  ? "د افغانستان د شطرنج د ملي ټیم لپاره د موبایل اپلیکیشن پروژه د رحمت الله احمدی او مرتضی یوسفي د لیسانس د درجې د دفاع لپاره د اړتیاو د یوې برخې په توګه جوړه شوې. دا پروژه د دوی تخنیکي مهارتونه، خلاقیت او سرښندنې څرګندوي چې د دوی د وړتیا د هراړخیز نمایش په توګه خدمت کوي. د یو پیچلي ګرځنده اپلیکیشن ډیزاین او پلي کول د دوی کار نه یوازې اکاډمیک اړتیاوې پوره کوي بلکې په افغانستان کې د شطرنج په وده او ملاتړ کې د پام وړ مرسته کوي."
                  : themeProvider.language == 'German'
                      ? "Dieses mobile Anwendungsprojekt für die afghanische Schachnationalmannschaft wurde als Teil der Anforderungen für die Verteidigung der Bachelor-Abschlüsse von Rahmatullah Ahmadi und Murtaza Yusufi entwickelt. Das Projekt stellt ihre technischen Fähigkeiten, ihre Kreativität und ihr Engagement unter Beweis und dient als umfassende Demonstration ihrer Fähigkeiten.“ eine anspruchsvolle mobile Anwendung zu entwerfen und umzusetzen. Ihre Arbeit erfüllt nicht nur akademische Anforderungen, sondern trägt auch wesentlich zur Förderung und Unterstützung des Schachs in Afghanistan bei"
                      : "This mobile application project for the Afghanistan Chess National Team was developed as part of the requirements for the defense of Rahmatullah Ahmadian and Murtaza Yusufi's Bachelor degrees. The project showcases their technical skills, creativity, and dedication, serving as a comprehensive demonstration of their ability to design and implement a sophisticated mobile application. Their work not only fulfills academic requirements but also contributes significantly to the promotion and support of chess in Afghanistan.";
  final String developerName = 'Rahmatullah Ahmadi \nMurtaza Yusufi';
  final String developerCompany = 'Kabul University';
  final String contactEmail = 'rahmatullahahmadion9@gmail.com\nmurtazayusufi1018@gmail.com';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text( themeProvider.language == 'English'
              ? 'About'
              : themeProvider.language == 'فارسی'
                  ? 'در باره'
                  : themeProvider.language == 'پشتو'
                  ? 'په اړه'
                  : themeProvider.language == 'German'
                      ? 'Über'
                      : 'About',),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Hero(
                tag: 'app-logo',
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/icon.png'), // Your app logo
                ),
              ),
            ),
            const SizedBox(height: 16),
             Center(
              child: Text(
               themeProvider.language == 'English'
              ? 'AFG Chess'
              : themeProvider.language == 'فارسی'
                  ? 'شطرنج افغانستان'
                  : themeProvider.language == 'پشتو'
                  ? 'د افغانستان شطرنج '
                  : themeProvider.language == 'German'
                      ? 'AFG Schach'
                      : 'AFG Chess',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                themeProvider.language == 'English'
              ? 'Version $appVersion'
              : themeProvider.language == 'فارسی'
                  ? 'نسخه $appVersion'
                  : themeProvider.language == 'پشتو'
                  ? 'نسخه $appVersion'
                  : themeProvider.language == 'German'
                      ? 'Version $appVersion'
                      : 'Version $appVersion',
               
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),
             Text(themeProvider.language == 'English'
              ? 'About My App'
              : themeProvider.language == 'فارسی'
                  ? 'درباره برنامه من'
                  : themeProvider.language == 'پشتو'
                  ? 'زما د اپلیکیشن په اړه'
                  : themeProvider.language == 'German'
                      ? 'Über meine App'
                      : 'About My App',
             
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appDescription,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
             Text(themeProvider.language == 'English'
              ? 'Developed by:'
              : themeProvider.language == 'فارسی'
                  ? 'توسعه یافته توسط:'
                  : themeProvider.language == 'پشتو'
                  ? 'لخوا رامینځته شوی:'
                  : themeProvider.language == 'German'
                      ? 'Entwickelt von:'
                      : 'Developed by:',
              
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(themeProvider.language == 'English'
              ? '$developerName\nIn: $developerCompany\nContact: $contactEmail\nSupervisor: Sayed Abed Sadat'
              : themeProvider.language == 'فارسی'
                  ? '$developerName\nدر: $developerCompany\nتماس: $contactEmail\nاستاد راهنما: سید عابد سادات'
                  : themeProvider.language == 'پشتو'
                  ? '$developerName\nپه: $developerCompany\nاړیکه: $contactEmail\nڅارونکی: سید عابد سادات'
                  : themeProvider.language == 'German'
                      ? '$developerName\nIn: $developerCompany\nKontakt: $contactEmail\nBetreuer: Sayed Abed Sadat'
                      : '$developerName\nIn: $developerCompany\nContact: $contactEmail\nSupervisor: Sayed Abed Sadat',
              
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(themeProvider.language == 'English'
              ? 'Follow us on:'
              : themeProvider.language == 'فارسی'
                  ? 'ما را دنبال کنید در:'
                  : themeProvider.language == 'پشتو'
                  ? 'موږ تعقیب کړئ:'
                  : themeProvider.language == 'German'
                      ? 'Folge uns auf:'
                      : 'Follow us on:',
              
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.web),
                  onPressed: () => _launchURL('https://whatsapp.com/channel/0029Vae8MflIt5rw4R1Pql1E'),
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () => _launchURL('https://www.facebook.com/profile.php?id=100013929243912'),
                ),
                IconButton(
                  icon: Icon(Icons.messenger_outlined),
                  onPressed: () => _launchURL('https://twitter.com/yourhandle'),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => _launchURL('https://linkedin.com/in/yourprofile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
