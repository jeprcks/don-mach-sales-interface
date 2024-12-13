@extends('Layout.app')
@section('title', 'Login')
@section('content')
    <div class="container-fluid d-flex justify-content-center align-items-center position-relative"
        style="height: 100vh; background: linear-gradient(135deg, #bc9681 0%, #6f4e37 100%);">
        <div class="position-absolute w-100 h-100"
            style="background: radial-gradient(circle at center, rgba(245, 230, 211, 0.1) 0%, rgba(111, 78, 55, 0.2) 100%);">
        </div>
        <div class="position-absolute text-center w-100" style="top: 10%; font-family: 'Playfair Display', serif;">
            <h1
                style="font-size: 4.5rem; color: rgba(245, 230, 211, 0.8); letter-spacing: 0.2rem; font-weight: 700; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(245, 230, 211, 0.2); transition: all 0.3s ease;">
                Don Macchiatos
            </h1>
        </div>
        <div class="col-md-4 col-lg-4 col-xl-4 position-relative">
            <div class="shadow p-4 rounded" style="background-color: rgba(255, 255, 255, 0.95);">
                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                @if (session('message'))
                    <div
                        class="alert {{ session('message') === 'Login Failed!' ? 'alert-danger' : 'alert-success' }} alert-dismissible fade show">
                        {{ session('message') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                @endif

                <form action="{{ route('admin.login') }}" method="POST" id="loginForm">
                    @csrf
                    <div class="card-header border-0 text-center mb-4">
                        <h1 class="display-5" style="color: #6f4e37;">Welcome Back</h1>
                        <p class="text-muted">Brew yourself a perfect day</p>
                    </div>
                    <div class="mb-4">
                        <label for="username" class="form-label" style="color: #8b593e;">Username</label>
                        <input type="text" name="username"
                            class="form-control border-2 @error('username') is-invalid @enderror"
                            style="background-color: #faf6f1;" id="username" value="{{ old('username') }}">
                        @error('username')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label" style="color: #8b593e;">Password</label>
                        <div class="input-group">
                            <input type="password" name="password"
                                class="form-control border-2 @error('password') is-invalid @enderror"
                                style="background-color: #faf6f1;" id="password">
                            @error('password')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    <button type="submit" class="btn w-100 py-2"
                        style="background-color: #6f4e37; color: #fff; border: none;">
                        Sign In
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            const alertMessage = document.querySelector('.alert');

            if (alertMessage) {
                setTimeout(() => {
                    alertMessage.classList.remove('show');
                    setTimeout(() => {
                        alertMessage.remove();
                    }, 150);
                }, 3000);
            }

            form.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;

                if (!username || !password) {
                    e.preventDefault();
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'alert alert-danger alert-dismissible fade show';
                    errorDiv.innerHTML = `
                        Please fill in all fields
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    `;
                    form.insertBefore(errorDiv, form.firstChild);

                    setTimeout(() => {
                        errorDiv.classList.remove('show');
                        setTimeout(() => {
                            errorDiv.remove();
                        }, 150);
                    }, 3000);
                }
            });
        });
    </script>
@endsection
