import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';
import 'package:aspectumai/features/chat/presentation/chat/bloc/chat/chat_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/illustrations.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';

part '../widgets/chat_response.dart';
part '../widgets/chat_input.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (_) => ChatBloc(sl()),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: bottomInsets),
          child: _ChatInput(),
        ),
        floatingActionButton:
            bottomInsets < 1 ? const _SuggestionStarters() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: AppColors.white),
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red,
                ),
              ),
              const AppSpacer.width(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Math Solver',
                        style: TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                      const AppSpacer.width(8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(IllustrationConstants.coin,
                                width: 10, height: 10),
                            const AppSpacer.width(4),
                            const Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'See details',
                        style: TextStyle(fontSize: 10, color: AppColors.grey),
                      ),
                      AppSpacer.width(4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.grey,
                        size: 10,
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              const Icon(Icons.bookmark_outline, color: AppColors.white),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.secondary,
              height: 1.0,
            ),
          ),
        ),
        body: const _ChatBody(),
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, List<ChatMessageEntity>>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            children: state.map((e) {
              if (e.role == 'assistant') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _AssistantMessage(text: e.content ?? ''),
                );
              } else if (e.role == 'user') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _UserMessage(text: e.content ?? ''),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SuggestionStarters extends StatelessWidget {
  const _SuggestionStarters();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                // context.read<ChatBloc>().add(
                //     StartChatEvent(message: ChatMessageEntity(content: '')));
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: index == 0 ? 10 : 0,
                  left: index == 1 ? 10 : 0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary),
                  color: AppColors.primary,
                ),
                child: const Text(
                  'What Can you do?',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
