import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipe/core/routing/routes.dart';
import 'package:recipe/features/category_detail/manager/category_detail_view_model.dart';
import 'package:recipe/features/category_detail/pages/category_detail_view.dart';
import 'package:recipe/features/community/manager/community_cubit.dart';
import 'package:recipe/features/community/pages/community_view.dart';
import 'package:recipe/features/home/manager/home_bloc.dart';
import 'package:recipe/features/home/pages/home_view.dart';
import 'package:recipe/features/recipe_detail/manager/recipe_detail_view_model.dart';
import 'package:recipe/features/recipe_detail/pages/recipe_detail_view.dart';
import 'package:recipe/features/reviews/manager/create_review/create_review_bloc.dart';
import 'package:recipe/features/reviews/manager/reviews/reviews_bloc.dart';
import 'package:recipe/features/reviews/pages/create_review_view.dart';
import 'package:recipe/features/reviews/pages/reviews_view.dart';
import 'package:recipe/features/top_chefs/manager/top_chefs_bloc.dart';
import 'package:recipe/features/top_chefs/pages/top_chefs_view.dart';
import 'package:recipe/features/trending_recipes/manager/trending_recipes_bloc.dart';
import 'package:recipe/features/trending_recipes/pages/trending_recipes_view.dart';

import '../../features/categories/managers/categories_cubit.dart';
import '../../features/categories/pages/categories_view.dart';
import '../../features/top_chefs/pages/top_chef_profile_view.dart';

final router = GoRouter(
  initialLocation: Routes.topChefs,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => BlocProvider(
        create: (context) => HomeBloc(
          catRepo: context.read(),
          recipeRepo: context.read(),
          chefRepo: context.read(),
        ),
        child: HomeView(),
      ),
    ),
    GoRoute(
      path: Routes.community,
      builder: (context, state) => BlocProvider(
        create: (context) => CommunityCubit(
          recipeRepo: context.read(),
        ),
        child: CommunityView(),
      ),
    ),
    GoRoute(
      path: Routes.categories,
      builder: (context, state) => BlocProvider(
        create: (context) => CategoriesBloc(
          catRepo: context.read(),
        ),
        child: CategoriesView(),
      ),
    ),
    GoRoute(
      path: Routes.categoryDetail,
      builder: (context, state) => BlocProvider(
        create: (context) => CategoryDetailBloc(
          catRepo: context.read(),
          recipeRepo: context.read(),
          selectedId: int.parse(state.pathParameters['categoryId']!),
        ),
        child: CategoryDetailView(),
      ),
    ),
    GoRoute(
      path: Routes.recipeDetail,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => RecipeDetailViewModel(
          recipeRepo: context.read(),
          recipeId: int.parse(state.pathParameters['recipeId']!),
        ),
        child: RecipeDetailView(),
      ),
    ),
    GoRoute(
      path: Routes.createReview,
      builder: (context, state) => BlocProvider(
        create: (context) => CreateReviewBloc(
          recipeRepo: context.read(),
          reviewRepo: context.read(),
        )..add(CreateReviewLoading(recipeId: int.parse(state.pathParameters['recipeId']!))),
        child: CreateReviewView(),
      ),
    ),
    GoRoute(
      path: Routes.reviews,
      builder: (context, state) => BlocProvider(
        create: (context) => ReviewsBloc(
          recipeRepo: context.read(),
          recipeId: int.parse(state.pathParameters['recipeId']!),
          reviewsRepo: context.read(),
        ),
        child: ReviewsView(),
      ),
    ),
    GoRoute(
      path: Routes.topChefs,
      builder: (context, state) => BlocProvider(
        create: (context) => TopChefsBloc(
          chefRepo: context.read(),
        ),
        child: TopChefsView(),
      ),
    ),
    GoRoute(
      path: Routes.topChefProfile,
      builder: (context, state) => TopChefProfileView(),
    ),
    GoRoute(
      path: Routes.trendingRecipes,
      builder: (context, state) => BlocProvider(
          create: (context) => TrendingRecipesBloc(
                recipeRepo: context.read(),
              ),
          child: TrendingRecipesView(),
      ),
    ),
  ],
);
