import 'package:first_pro/models/message.dart';
import 'package:first_pro/models/room.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.user()?.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: StreamBuilder<List<Message>>(
        stream: Supabase.instance.client
            .from('messages:room_id=eq.${room.id}')
            .stream(["id"])
            .order("created_at")
            .execute()
            .map((maps) => maps.map(Message.fromMap).toList()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loding..."),
            );
          }
          final messages = snapshot.data!;
          if (messages.isEmpty) {
            return const Center(
              child: Text("noone has started talking yet...."),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: ((context, index) {
              final message = messages[index];
              return Align(
                alignment: userId == message.profileId
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(4),
                    color: userId == message.profileId
                        ? Colors.blue[200]
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        message.content,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
