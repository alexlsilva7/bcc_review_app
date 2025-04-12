// GENERATED FILE. PLEASE DO NOT EDIT THIS FILE!!

part of 'app_widget.dart';

List<RouteEntity> get routes => [
  RouteEntity(key: '/home', uri: Uri.parse('/home'), routeBuilder: b0Builder),
  RouteEntity(key: '/login', uri: Uri.parse('/login'), routeBuilder: b1Builder),
  RouteEntity(
    key: '/minigames/minigame_selection',
    uri: Uri.parse('/minigames/minigame_selection'),
    routeBuilder: b2Builder,
  ),
  RouteEntity(
    key: '/minigames/snake/snake_game',
    uri: Uri.parse('/minigames/snake/snake_game'),
    routeBuilder: b3Builder,
  ),
  RouteEntity(
    key: '/module/[id]/show',
    uri: Uri.parse('/module/[id]/show'),
    routeBuilder: b4Builder,
  ),
  RouteEntity(
    key: '/quiz/[id]/quiz',
    uri: Uri.parse('/quiz/[id]/quiz'),
    routeBuilder: b5Builder,
  ),
  RouteEntity(
    key: '/settings',
    uri: Uri.parse('/settings'),
    routeBuilder: b6Builder,
  ),
  RouteEntity(
    key: '/splash',
    uri: Uri.parse('/splash'),
    routeBuilder: b7Builder,
  ),
];

const routePaths = (
  path: '/',
  home: '/home',
  login: '/login',
  minigames: (
    path: '/minigames',
    minigameSelection: '/minigames/minigame_selection',
    snake: (path: '/minigames/snake', snakeGame: '/minigames/snake/snake_game'),
  ),
  module: (
    path: '/module',
    $id: (path: '/module/[id]', show: '/module/[id]/show'),
  ),
  quiz: (path: '/quiz', $id: (path: '/quiz/[id]', quiz: '/quiz/[id]/quiz')),
  settings: '/settings',
  splash: '/splash',
);
