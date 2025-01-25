<?php
//Ici c'est la partie ou on indique les variables ou donnee de l'utilisateur peut modifier 
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'body'
    ];
}