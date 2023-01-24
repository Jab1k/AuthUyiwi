import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../model/model.dart';

class FacebookPage extends StatelessWidget {
  const FacebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${context.watch<Controller>().userdata?.name}',
                  style: TextStyle(fontSize: 25),
                ),
                Text('${context.watch<Controller>().userdata?.email}'),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            ClipOval(
                child: Image.network(
              context.watch<Controller>().userdata?.image ?? '',
            ))
          ],
        ),
      ),
    );
  }
}
