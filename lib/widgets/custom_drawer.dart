// import 'package:awesome_dialog/awesome_dialog.dart';
//
// import 'package:flutter/material.dart';
//
//
//
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({required Key key}) : super(key: key);
//
//   @override
//   _CustomDrawerState createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//   bool _showAdmin = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//       child: Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(user?.displayName ?? 'Blood Donation'),
//               accountEmail: Text(user?.email ?? AppConfig.email),
//               otherAccountsPictures: [
//                     const Tooltip(
//                       message: 'Admin Screens',
//                       child: CircleAvatar(child: Icon(Istos.user_secret)),
//                     ),
//                   ),
//                 InkWell(
//                   onTap: () {
//                     AwesomeDialog(
//                       context: context,
//                       headerAnimationLoop: false,
//                       dialogType: DialogType.WARNING,
//                       title: 'Logout',
//                       desc: 'Are you sure you want to logout?',
//                       btnCancelText: 'NO',
//                       btnCancelOnPress: () {},
//                       btnOkText: 'YES',
//                       btnOkOnPress: () {
//                         Navigator.of(context).pushNamedAndRemoveUntil(
//                           LoginScreen.route,
//                               (route) => false,
//                         );
//                       },
//                     ).show();
//                   },
//                   child: const Tooltip(
//                     message: 'Logout',
//                     child: CircleAvatar(child: Icon(Istos.unlocked)),
//                   ),
//                 ),
//               ],
//               currentAccountPicture: Hero(
//                 tag: 'profilePicHero',
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: MainColors.accent,
//                     shape: BoxShape.circle,
//                   ),
//                   clipBehavior: Clip.hardEdge,
//                   child: user?.photoURL != null
//                       ? CachedNetworkImage(
//                     imageUrl: user.photoURL,
//                     fit: BoxFit.cover,
//                     placeholder: (_, __) => const Center(
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2.5,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           Colors.white70,
//                         ),
//                       ),
//                     ),
//                   )
//                       : SvgPicture.asset(IconAssets.donor),
//                 ),
//               ),
//               margin: EdgeInsets.zero,
//             ),
//             Expanded(child: Column(children: _screens)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> get _screens => [
//     const _DrawerTile(
//       title: 'Profile',
//       icon: Istos.person,
//       destination: ProfileScreen.route,
//     ),
//     const _DrawerTile(
//       title: 'Request Blood',
//       icon: Istos.blood,
//       destination: AddBloodRequestScreen.route,
//     ),
//     if (_showAdmin)
//       const _DrawerTile(
//         title: 'Add News',
//         icon: Istos.plus_a,
//         destination: AddNewsItem.route,
//       ),
//     const _DrawerTile(
//       title: 'News and Tips',
//       icon: Istos.bell,
//       destination: NewsScreen.route,
//     ),
//     const _DrawerTile(
//       title: 'Can I donate blood?',
//       icon: Istos.question_circle,
//       destination: WhoCanDonateScreen.route,
//     ),
//   ];
// }
//
// class _DrawerTile extends StatelessWidget {
//   final String title, destination;
//   final IconData icon;
//
//   const _DrawerTile({
//     Key key,
//     @required this.title,
//     @required this.icon,
//     @required this.destination,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       leading: Icon(icon),
//       onTap: () {
//         Navigator.pop(context);
//         Navigator.of(context).pushNamed(destination);
//       },
//     );
//   }
// }