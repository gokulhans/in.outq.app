import 'package:flutter/material.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';

class UserNotifications extends StatelessWidget {
  const UserNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: UserAppBarWithBack(
            title: "Notifications",
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (context, index) {
              return const ListTile(
                title: SingleNotiListTile(),
              );
            },
          ),
        ));
  }
}

class SingleNotiListTile extends StatelessWidget {
  const SingleNotiListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: const Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.blue,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This is a Sample Notification',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Herbal Pancake',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
