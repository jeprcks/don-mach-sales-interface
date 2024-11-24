<?php

namespace App\Application\User;

use App\Domain\Entities\User;
use App\Infrastructure\Persistence\Eloquent\User\EloquentUserRepository;
use Exception;
use Illuminate\Support\Facades\Hash;

class RegisterUser
{
    private EloquentUserRepository $userRepository;

    public function __construct(EloquentUserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function execute(string $username, string $password): void
    {
        try {
            // Check if username already exists
            $existingUser = $this->userRepository->findByUsername($username);
            if ($existingUser) {
                throw new Exception('Username already exists');
            }

            // Validate username
            if (empty($username)) {
                throw new Exception('Username cannot be empty');
            }

            // Validate password
            if (strlen($password) < 6) {
                throw new Exception('Password must be at least 6 characters');
            }

            // Create new user entity
            $user = new User(
                $username,
                Hash::make($password)
            );

            // Save to repository
            $this->userRepository->save($user);

        } catch (Exception $e) {
            throw new Exception('Failed to register user: ' . $e->getMessage());
        }
    }

    public function findAll()
    {
        try {
            return $this->userRepository->findAll();
        } catch (Exception $e) {
            throw new Exception('Failed to fetch users: ' . $e->getMessage());
        }
    }

    public function findByUsername(string $username)
    {
        try {
            return $this->userRepository->findByUsername($username);
        } catch (Exception $e) {
            throw new Exception('Failed to find user: ' . $e->getMessage());
        }
    }

    public function update(string $username, string $newPassword): void
    {
        try {
            $user = $this->userRepository->findByUsername($username);
            if (!$user) {
                throw new Exception('User not found');
            }

            if (strlen($newPassword) < 6) {
                throw new Exception('Password must be at least 6 characters');
            }

            $this->userRepository->update($username, Hash::make($newPassword));
        } catch (Exception $e) {
            throw new Exception('Failed to update user: ' . $e->getMessage());
        }
    }

    public function delete(string $username): void
    {
        try {
            $user = $this->userRepository->findByUsername($username);
            if (!$user) {
                throw new Exception('User not found');
            }

            $this->userRepository->delete($username);
        } catch (Exception $e) {
            throw new Exception('Failed to delete user: ' . $e->getMessage());
        }
    }
}
