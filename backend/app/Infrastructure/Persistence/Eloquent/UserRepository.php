<?php

namespace App\Infrastructure\Persistence\Eloquent;

use App\Domain\Entities\User;
use Illuminate\Support\Facades\DB;

class UserRepository
{
    public function findByEmail(string $email): ?User
    {
        $user = DB::table('users')->where('email', $email)->first();

        if ($user) {
            return new User($user->email, $user->password);
        }

        return null;
    }
}
