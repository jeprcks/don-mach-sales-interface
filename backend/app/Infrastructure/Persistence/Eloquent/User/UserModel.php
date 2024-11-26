<?php

namespace App\Infrastructure\Persistence\Eloquent\User;

use Illuminate\Database\Eloquent\Model;

class UserModel extends Model
{
    protected $table = 'users';

    protected $fillable = [
        'username',
        'password'
    ];

    protected $hidden = [
        'password',
    ];

    // If you don't want to use timestamps (created_at, updated_at)
    // uncomment the following line
    // public $timestamps = false;
}
