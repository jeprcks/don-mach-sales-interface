<?php

namespace App\Infrastructure\Persistence\Eloquent\User;

use App\Domain\Users\User;
use App\Domain\Users\UserRepository;

// use Exception;

class EloquentUserRepository implements UserRepository
{
    public function create(User $user)
    {
        $data = new UserModel;
        $data->username = $user->getUsername();
        $data->password = $user->getPassword();
        $data->save();

        return $data;
    }

    public function update(User $user): void
    {

        $data = UserModel::find($user->getID()) ?? new UserModel;
        $data->id = $user->getID();
        $data->username = $user->getID();
        $data->password = $user->getPassword();

    }

    public function delete(int $id): void
    {
        UserModel::where('id', $id)->delete();
    }

    public function findByUsername(string $username): ?User
    {
        $data = UserModel::where('username', $username);
        if (! $user) {
            return null;
        }

        return new User($data->id, $data->username); //sakto
    }

    public function findAll(): array
    {
        return $this->UserRepository->findAll();
    }

    // public function save(User $user): void
    // {
    //     // sakto naman lagi ni mo gna ni cya oo gana na kato ako ge pakita nimo gege
    //     try {
    //         UserModel::create([
    //             'username' => $user->getUsername(),
    //             'password' => $user->getPassword(),
    //         ]);
    //     } catch (Exception $e) {
    //         throw new Exception('Failed to save user: '.$e->getMessage());
    //     }
    // }

    // public function findByUsername(string $username): ?User
    // {
    //     $user = UserModel::where('username', $username)->first();

    //     if ($user) {
    //         return new User($user->username, $user->password);
    //     }

    //     return null;
    // }

    // public function findAll(): array
    // {
    //     return UserModel::all()->map(function ($user) {
    //         return new User($user->username, $user->password);
    //     })->toArray();
    // }

    // public function update(string $username, string $hashedPassword): void
    // {
    //     UserModel::where('username', $username)->update([
    //         'password' => $hashedPassword,
    //     ]);
    // }

    // public function delete(string $username): void
    // {
    //     UserModel::where('username', $username)->delete();
    // }
}
