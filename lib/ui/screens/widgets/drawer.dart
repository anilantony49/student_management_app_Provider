// import 'package:database_student/providers/recepie_providers.dart';
// import 'package:flutter/material.dart';

// class DrawerList extends StatefulWidget {
//   const DrawerList({super.key});

//   @override
//   State<DrawerList> createState() => _DrawerListState();
// }

// class _DrawerListState extends State<DrawerList> {
//   @override
//   Widget build(BuildContext context) {
//     RecipeManager recipeManager = RecipeManager();

//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 200,
//           color: !recipeManager.isDark ? Colors.blue : null,
//           child: Center(
//             child: CircleAvatar(
//               backgroundImage: AssetImage('assets/images/student iimage2.jpg'),
//               radius: 50,
//             ),
//           ),
//         ),
//         ListTile(
//           title: Text('Home'),
//           leading: Icon(
//             Icons.home,
//             color: Colors.black,
//           ),
//           onTap: () {
//             Navigator.pushReplacementNamed(context, '/main_recipe_screen');
//           },
//         ),
//         ListTile(
//           title: Text('Favorite Racipes'),
//           leading: Icon(
//             Icons.favorite,
//             color: Colors.red,
//           ),
//           onTap: () {
//             Navigator.pushReplacementNamed(context, '/favorite_recipes_screen');
//           },
//         ),
//         Divider(
//           thickness: 1,
//         ),
//         ListTile(
//           title: Text('Shopping List'),
//           leading: Icon(
//             Icons.shopping_cart,
//             color: Colors.black,
//           ),
//           onTap: () {},
//         ),
//         Divider(
//           thickness: 1,
//         ),
//         recipeManager.isDark
//             ? ListTile(
//                 title: Text('Light Mode'),
//                 leading: Icon(
//                   Icons.light_mode_outlined,
//                   color: Colors.black,
//                 ),
//                 onTap: () {
//                   recipeManager.changeIsDark();

//                   // Provider.of<RecipeClass>(context, listen: false)
//                   //     .changeIsDark();
//                   Navigator.pop(context);
//                 },
//               )
//             : ListTile(
//                 title: Text('Dark Mode'),
//                 leading: Icon(
//                   Icons.dark_mode_outlined,
//                   color: Colors.black,
//                 ),
//                 onTap: () {
//                   recipeManager.changeIsDark();
//                   // Provider.of<RecipeClass>(context, listen: false)
//                   //     .changeIsDark();
//                   Navigator.pop(context);
//                 },
//               )
//       ],
//     );
//   }
// }
