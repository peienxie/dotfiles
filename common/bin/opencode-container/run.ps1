#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

function Usage {
    @'
Usage: run.ps1 [options]

Options:
  -b, --rebuild        Force rebuild the image
  -i, --image IMAGE    Image name (default: opencode:latest)
  -n, --name NAME      Container name (default: opencode)
  -h, --help           Show this help
'@
}

# detect engine (podman preferred)
$podman = Get-Command podman -ErrorAction SilentlyContinue
$docker = Get-Command docker -ErrorAction SilentlyContinue
if ($podman) { $ENGINE = 'podman' }
elseif ($docker) { $ENGINE = 'docker' }
else { Write-Error 'No container engine found (podman or docker)'; exit 1 }

# defaults
$IMAGE = 'opencode:latest'
$CONTAINER_NAME = 'opencode'
$FORCE_BUILD = $false
$SCRIPT_DIR = $PSScriptRoot

# parse args
for ($i = 0; $i -lt $args.Length;) {
    switch ($args[$i]) {
        '-b' { $FORCE_BUILD = $true; $i++ }
        '--rebuild' { $FORCE_BUILD = $true; $i++ }
        '-i' { $IMAGE = $args[$i + 1]; $i += 2 }
        '--image' { $IMAGE = $args[$i + 1]; $i += 2 }
        '-n' { $CONTAINER_NAME = $args[$i + 1]; $i += 2 }
        '--name' { $CONTAINER_NAME = $args[$i + 1]; $i += 2 }
        '-h' { Usage; exit 0 }
        '--help' { Usage; exit 0 }
        Default { Write-Error "Unknown option: $($args[$i])"; Usage; exit 2 }
    }
}

function ImageExists($engine, $image) {
    & $engine image inspect $image > $null 2>&1
    return ($LASTEXITCODE -eq 0)
}

if ($FORCE_BUILD) {
    Write-Output "Forcing rebuild of $IMAGE"
    $build = $true
} elseif (ImageExists $ENGINE $IMAGE) {
    Write-Output "Image $IMAGE found locally."
    $build = $false
} else {
    Write-Output "Image $IMAGE not found. Will build."
    $build = $true
}

if ($build) {
    Write-Output "Building image: $IMAGE"
    $buildArgs = @('build', '-t', $IMAGE) + @($SCRIPT_DIR)
    & $ENGINE @buildArgs
    if ($LASTEXITCODE -ne 0) { Write-Error 'Image build failed'; exit $LASTEXITCODE }
}

# run container
$runOpts = @(
    '--name', $CONTAINER_NAME,
    '-v', "$HOME/.local/state/opencode:/home/opencode/.local/state/opencode",
    '-v', "$HOME/.local/share/opencode:/home/opencode/.local/share/opencode",
    '-v', "${PWD}:/workspace",
    '-w', '/workspace'
)

Write-Output "Starting container $CONTAINER_NAME"
$runArgs = @('run','-it','--rm') + $runOpts + @($IMAGE)
& $ENGINE @runArgs
exit $LASTEXITCODE
