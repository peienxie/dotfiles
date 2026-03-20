#!/usr/bin/env pwsh

$podman = Get-Command podman -ErrorAction SilentlyContinue
$docker = Get-Command docker -ErrorAction SilentlyContinue

if ($podman) {
    $ENGINE = "podman"
} elseif ($docker) {
    $ENGINE = "docker"
} else {
    Write-Error "No container engine found (podman or docker)"
    exit 1
}

& $engine build -t opencode .
