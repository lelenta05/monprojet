<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post ;//C'est ton modèle, qui représente la table posts dans la base de données


class PostController extends Controller
{

    /**
     * La fonction store ajoute un nouvel article à la base de données.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|max:255',
            'body' => 'required'
           ]);
           // Crée un nouveau post avec les données validées
           Post::create($request->all());
           // Redirige vers la route 'posts.index' avec un message de succès
           return redirect()->route('posts.index')
            ->with('success','Post created successfully.');
           
    }
    
    /**
     * affichage de tous les posts
     */
    public function index()
    {
        // Récupère tous les enregistrements de la table 'posts'.
        $post=Post:: all();
        return view('posts.index',compact('post'));
    }

  
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request -> validate([
            'title' => 'required|max:225',
            'body' => 'required'
        ]);
        // Trouve le post par son ID
        $post= Post::find($id);
        if (!$post) {
            return redirect()->route('posts.index')
                ->with('error', 'Post not found!');
        }
        // Met à jour le post avec les nouvelles données
        $post -> update($request-> all());

        return redirect() -> route ('posts.index')
        ->with('succes','Post update successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $post= Post::find($id);
        $post ->delete();
        return redirect() -> route ('posts.index')
        -> with('success','Post deleted successfully');
    }
      /**
     * Cette méthode show permet d'afficher un post particulier en fonction de son ID.
     */
    public function show(string $id)
    {
        $post=Post :: find($id);
        return view('posts.show',compact('posts'));
    }

     /**
     * Cette méthode edit permet de modifier un post particulier en fonction de son ID.
     */
    public function edit($id)
    {
        $post = Post :: find ($id);
        return view('posts.edit',compact('post'));
    }
    
    /**
     *  Cette méthode renvoie la vue posts.create, qui contient un formulaire pour ajouter un nouveau post.
     *  Elle ne fait rien de plus que d'afficher ce formulaire.
     */
    public function create ()
    {
        return view ('posts.create');
        
    }
}
