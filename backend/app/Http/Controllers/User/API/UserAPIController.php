<?php

namespace App\Http\Controllers\User\API;

use App\Application\User\RegisterUser;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserAPIController extends Controller
{
    private RegisterUser $registerUser;

    public function __construct(RegisterUser $registerUser)
    {
        $this->registerUser = $registerUser;
    }

    public function register(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'username' => 'required|string|min:3',
                'password' => 'required|string|min:6'
            ]);

            $this->registerUser->execute(
                $request->username,
                $request->password
            );

            return response()->json([
                'status' => 'success',
                'message' => 'User registered successfully'
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 400);
        }
    }

    public function findAll(): JsonResponse
    {
        try {
            $users = $this->registerUser->findAll();
            
            return response()->json([
                'status' => 'success',
                'data' => $users
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function findByUsername(string $username): JsonResponse
    {
        try {
            $user = $this->registerUser->findByUsername($username);

            if (!$user) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'User not found'
                ], 404);
            }

            return response()->json([
                'status' => 'success',
                'data' => $user
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'username' => 'required|string',
                'password' => 'required|string|min:6'
            ]);

            $this->registerUser->update(
                $request->username,
                $request->password
            );

            return response()->json([
                'status' => 'success',
                'message' => 'User updated successfully'
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 400);
        }
    }

    public function delete(string $username): JsonResponse
    {
        try {
            $this->registerUser->delete($username);

            return response()->json([
                'status' => 'success',
                'message' => 'User deleted successfully'
            ]);

        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 400);
        }
    }
}
