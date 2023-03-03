import 'package:flutter/material.dart';
import 'package:outq/utils/sizes.dart';

class UserChatListPage extends StatelessWidget {
  const UserChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
              height: 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: SingleChatListTile(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleChatListTile extends StatelessWidget {
  const SingleChatListTile({super.key});

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
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: const Icon(Icons.notifications)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Herbal Pancake',
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
