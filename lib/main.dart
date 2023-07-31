// ignore_for_file: unused_local_variable

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:dart_appwrite_test/constants.dart';

void main() async {
  Client client = Client()
      .setEndpoint(APPWRITE_API_ENDPOINT)
      .setProject(APPWRITE_PROJECT_ID)
      .setKey(SECRET_APPWRITE_KEY)
      .setSelfSigned();

  Users users = Users(client);
  Databases databases = Databases(client);

  try {
    final user = await users.create(
      userId: ID.unique(),
      email: 'abc@gmail.com',
      password: '12345678',
      name: 'John Watt',
    );
    print(user.toMap());
    final DocumentList messages = await databases.listDocuments(
      databaseId: APPWRITE_DATABASE_ID,
      collectionId: COLLECTION_MESSAGES_ID,
    );
    for (var message in messages.documents) {
      print(message.data['user_id'] + ': ' + message.data['text']);
    }
  } on AppwriteException catch (e) {
    print(e.message);
  }
}
