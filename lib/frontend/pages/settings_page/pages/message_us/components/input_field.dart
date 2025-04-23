part of '../message_us_page.dart';

class _InputField extends StatelessWidget {
  const _InputField();

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final TextEditingController contactController = TextEditingController();

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: messageController,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your message',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: contactController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your contact information',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final contactInfo = contactController.text;
              final message = messageController.text;
              if (contactInfo.isNotEmpty && message.isNotEmpty) {
                context.read<ReportBloc>().add(
                  SendUsMessageEvent(message, contactInfo),
                );
                messageController.clear();
                contactController.clear();
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
