import 'package:aspectumai/core/app_route.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/widgets/agent_cards/agent_card_large.dart';
import 'package:aspectumai/core/widgets/agent_cards/agent_card_small.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:aspectumai/core/widgets/label.dart';
import 'package:aspectumai/core/widgets/section_header.dart';
import 'package:aspectumai/features/home/models/home_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data untuk carousel
  final List<CarouselItem> carouselItems = [
    CarouselItem(
      title: "Disney Master",
      category: "Creative & Art",
      description:
          "Lorem ipsum damet Lorem ipsum damet Lorem ipsum damet ipsum damet",
      imageUrl:
          "https://analyticsindiamag.com/wp-content/uploads/2020/08/432a6b258bfa7df163a88bed81255db6.jpg",
    ),
    CarouselItem(
      title: "Math Solver",
      category: "Education",
      description: "Advanced AI assistant for mathematical problem solving",
      imageUrl:
          "https://analyticsindiamag.com/wp-content/uploads/2020/08/432a6b258bfa7df163a88bed81255db6.jpg",
    ),
    CarouselItem(
      title: "Code Assistant",
      category: "Programming",
      description:
          "Your personal coding companion for any programming language",
      imageUrl:
          "https://analyticsindiamag.com/wp-content/uploads/2020/08/432a6b258bfa7df163a88bed81255db6.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Data untuk action buttons
    List<ActionButtonItem> actionButtons = [
      ActionButtonItem(
        label: "Start New Chat",
        icon: Icons.chat,
        backgroundColor: const Color(0xFF4ECDC4),
        isExpanded: true,
        onTap: () {
          context.push(rChat);
        },
      ),
      ActionButtonItem(
        icon: Icons.camera_alt_outlined,
        backgroundColor: AppColors.secondary,
        onTap: () {
          // TODO: Open camera
        },
      ),
      ActionButtonItem(
        icon: Icons.headphones_outlined,
        backgroundColor: AppColors.secondary,
        onTap: () {
          // TODO: Open audio input
        },
      ),
      ActionButtonItem(
        icon: Icons.mic_outlined,
        backgroundColor: AppColors.secondary,
        onTap: () {
          // TODO: Open voice input
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            const AppSpacer.height(kToolbarHeight),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(),
                  AppSpacer.width(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Febry Ardiansyah",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        "Let's see what can I do for you today?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AppSpacer.height(24),
            // const _SearchBar(),
            // const AppSpacer.height(16),

            /// carousel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items: carouselItems.map((item) {
                  return CarouselCard(
                    title: item.title,
                    category: item.category,
                    description: item.description,
                    imageUrl: item.imageUrl,
                  );
                }).toList(),
              ),
            ),
            const AppSpacer.height(16),

            /// action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: actionButtons.map((button) {
                  if (button.isExpanded) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: button.onTap,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: button.backgroundColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              button.label ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: actionButtons.indexOf(button) == 1 ? 12 : 8,
                      ),
                      child: GestureDetector(
                        onTap: button.onTap,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: button.backgroundColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            button.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
            const AppSpacer.height(16),

            /// category filter
            // const _CategoryFilter(),
            // const AppSpacer.height(16),

            /// popular
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: SectionHeader(title: "Popular"),
            // ),
            // const SizedBox(height: 8),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(
            //       5,
            //       (index) {
            //         return const Padding(
            //           padding: EdgeInsets.only(right: 16, left: 20),
            //           child: AgentsCardLarge(
            //             title: "Math Solver",
            //             category: "Education",
            //             description: "Lorem ipsum damet Lorem ipsum damet",
            //             imageUrl: "https://via.placeholder.com/100",
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // const AppSpacer.height(16),

            // /// newest
            // const SectionHeader(title: "Newest"),
            // const SizedBox(height: 8),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Column(
            //     children: [
            //       Row(
            //         children: List.generate(
            //           5,
            //           (index) {
            //             return const Padding(
            //               padding: EdgeInsets.only(right: 16),
            //               child: AgentCardSmall(
            //                 title: "Math Solver",
            //                 category: "Education",
            //                 description: "Lorem ipsum damet Lorem ipsum damet",
            //                 imageUrl: "https://via.placeholder.com/100",
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //       const AppSpacer.height(18),
            //       Row(
            //         children: List.generate(
            //           5,
            //           (index) {
            //             return const Padding(
            //               padding: EdgeInsets.only(right: 16),
            //               child: AgentCardSmall(
            //                 title: "Math Solver",
            //                 category: "Education",
            //                 description: "Lorem ipsum damet Lorem ipsum damet",
            //                 imageUrl: "https://via.placeholder.com/100",
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return const AppTextForm(
      prefixIcon: Icon(Icons.search, color: Colors.white70),
      hint: "Search here..",
    );
  }
}

class CarouselCard extends StatelessWidget {
  final String title, category, description, imageUrl;

  const CarouselCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
              left: 11,
            ),
            child: LabelWidget(label: category),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context) {
    final List<String> labels = [
      "All",
      "Productivity & Work",
      "Creative & Art",
      "Education & Learning",
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: labels
            .map(
              (label) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: LabelWidget(label: label),
              ),
            )
            .toList(),
      ),
    );
  }
}
