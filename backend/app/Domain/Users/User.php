<?php

namespace App\Domain\Users;

class User
{
    private ?int $id;

    private string $username;

    private string $password;

    public function __construct(
        ?int $id = null,
        ?string $username = null,
        ?string $password = null
    ) {
        $this->id = $id ?? 0;
        $this->username = $username ?? '';
        $this->password = $password ?? '';
    }

    public function getID(): ?int
    {
        return $this->id;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getPassword(): string
    {
        return $this->password;
    }
}
