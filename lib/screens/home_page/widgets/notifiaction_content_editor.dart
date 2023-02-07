// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../../../services/screen_time_Interface.dart';

// class NotificationContentEditor extends StatefulWidget {
//   final ScreenTimeInterface screenTimeInterface;
//   const NotificationContentEditor(
//       {super.key, required this.screenTimeInterface});

//   @override
//   State<NotificationContentEditor> createState() =>
//       _NotificationContentEditorState();
// }

// class _NotificationContentEditorState extends State<NotificationContentEditor> {
//   TextEditingController notificationTitleController = TextEditingController();
//   TextEditingController notificationDescriptionController =
//       TextEditingController();

//   var _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ExpansionTile(
//         leading: Icon(
//           Icons.timelapse,
//         ),
//         title: Text(
//           "Edit Notification",
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         childrenPadding: EdgeInsets.all(16),
//         children: [
//           TextFormField(
//             controller: notificationTitleController,
//             validator: (value) {
//               if ((value?.length ?? 0) < 4) {
//                 return "Length must be more than 4 characters.";
//               }
//             },
//             decoration: InputDecoration(
//               label: Text("Title"),
//               errorStyle: TextStyle(fontSize: 10),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               contentPadding: EdgeInsets.all(10),
//               icon: Icon(Icons.title),
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           TextFormField(
//             controller: notificationDescriptionController,
//             maxLines: 5,
//             minLines: 1,
//             textAlign: TextAlign.start,
//             validator: (value) {
//               if ((value?.length ?? 0) < 4) {
//                 return "Length must be more than 4 characters.";
//               }
//             },
//             decoration: InputDecoration(
//               label: Text("Description"),
//               errorStyle: TextStyle(fontSize: 10),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               contentPadding: EdgeInsets.all(10),
//               icon: Icon(Icons.description),
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 bool? isValid = _formKey.currentState?.validate();
//                 if (isValid ?? false) {
//                   await widget.screenTimeInterface.saveNotificationContent(
//                       notificationTitleController.text,
//                       notificationDescriptionController.text);
//                   notificationTitleController.clear();
//                   notificationDescriptionController.clear();
//                 }
//               },
//               child: Text("Save"))
//         ],
//       ),
//     );
//   }
// }
