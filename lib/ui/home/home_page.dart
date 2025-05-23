import 'package:bcc_review_app/app_widget.dart';
import 'package:bcc_review_app/config/dependecies.dart';
import 'package:bcc_review_app/core/extensions/date_only_compare.dart';
import 'package:bcc_review_app/ui/home/home_view_model.dart';
import 'package:bcc_review_app/ui/home/my_modules/my_modules_view.dart';
import 'package:bcc_review_app/ui/home/official_modules/official_modules_view.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = injector.get<HomeViewModel>();
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentIndex = 0;

  @override
  void initState() {
    viewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Routefly.push(routePaths.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        title: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return Row(
              children: [
                const CircleAvatar(
                  radius: 17,
                  child: Icon(Icons.person, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstChild: const Text('Carregando...'),
                    secondChild: Text(
                      viewModel.user?.name ?? "...",
                      overflow: TextOverflow.ellipsis,
                    ),
                    crossFadeState: viewModel.user == null
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ),
                if (pageController.hasClients && pageController.page == 0)
                  InkWell(
                    onTap: () {
                      setState(() {
                        viewModel.isStatsPanelVisible =
                        !viewModel.isStatsPanelVisible;
                        if (viewModel.showStatsPanelContent) {
                          viewModel.showStatsPanelContent =
                          !viewModel.showStatsPanelContent;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        key: const Key('xp_button'),
                        children: [
                          Icon(Icons.school, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text('${viewModel.user?.level ?? 0}'),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.local_fire_department,
                            color: viewModel.user != null &&
                                viewModel.user?.lastDailySequenceDate != null &&
                                viewModel.user!.lastDailySequenceDate!
                                    .isSameDate(DateTime.now())
                                ? Colors.orange[900]
                                : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(100),
                          ),
                          const SizedBox(width: 4),
                          Text('${viewModel.user?.dailySequence ?? 0}'),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          OfficialModulesView(
            viewModel: injector.get(),
            homeViewModel: viewModel,
          ),
          MyModulesView(viewModel: injector.get()),
        ],
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
            tooltip: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Meus Módulos',
            tooltip: 'Meus Módulos',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        key: const Key('minigames_button'),
        onPressed: () {
          Routefly.push('/minigames/minigame_selection');
        },
        tooltip: 'Abrir Minijogos',
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.videogame_asset),
      ),
    );
  }
}
