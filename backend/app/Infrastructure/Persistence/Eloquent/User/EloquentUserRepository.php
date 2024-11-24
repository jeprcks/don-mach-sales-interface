<?php

namespace App\Infrastructure\Persistence\Eloquent\User;

use App\Domain\Entities\User;
use Exception;

class EloquentUserRepository
{
    public function save(User $user): void
    {
        try {
            UserModel::create([
                'username' => $user->getUsername(),
                'password' => $user->getPassword(),
            ]);
        } catch (Exception $e) {
            throw new Exception('Failed to save user: '.$e->getMessage());
        }
    }

    public function findByUsername(string $username): ?User
    {
        $user = UserModel::where('username', $username)->first();

        if ($user) {
            return new User($user->username, $user->password);
        }

        return null;
    }

    public function findAll(): array
    {
        return UserModel::all()->map(function ($user) {
            return new User($user->username, $user->password);
        })->toArray();
    }

    public function update(string $username, string $hashedPassword): void
    {
        UserModel::where('username', $username)->update([
            'password' => $hashedPassword,
        ]);
    }

    public function delete(string $username): void
    {
        UserModel::where('username', $username)->delete();
    }
}
