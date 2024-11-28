@extends('Layout.app')
@section('title', 'Login')
@section('content')
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="col-md-4 col-lg-4 col-xl-4">
            <div class="shadow p-3 mb-5 bg-body-tertiary rounded">
                <form action="#">
                    <div class="card-header">
                        <h1 class="display-5">Login</h1>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">Username</label>
                        <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                        
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="exampleInputPassword1">
                        </div>
                    </div>

                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
