<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PostController;



/// Renvoie la page d'accueil avec tous les posts
Route::get('/', [PostController::class , 'index'])->name('posts.index');

// Renvoie le formulaire pour ajouter un post
Route::get('/posts/create', [PostController::class , 'create'])->name('posts.create');

// Ajoute un post dans la base de données
Route::post('/posts', [PostController::class ,'store'])->name('posts.store');

// Renvoie une page qui affiche un post complet avec l'ID {post}.
Route::get('/posts/{post}', [PostController::class , 'show'])->name('posts.show');

// Renvoie le formulaire pour éditer un post
Route::get('/posts/{post}/edit', [PostController::class , 'edit'])->name('posts.edit');

// Met à jour un post
Route::put('/posts/{post}',[PostController::class , 'update'])->name('posts.update');

// Supprime un post
Route::delete('/posts/{post}', [PostController::class , 'destroy'])->name('posts.destroy');
