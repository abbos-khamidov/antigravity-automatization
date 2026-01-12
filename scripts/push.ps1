Write-Host "Running formatters and linters..."
black .
ruff check .

Write-Host "Running tests..."
pytest
$code = $LASTEXITCODE

if ($code -eq 5) {
    Write-Host "No tests found - skipping."
}
elseif ($code -ne 0) {
    Write-Host "Tests failed. Aborting."
    exit 1
}

git status
$msg = Read-Host "Commit message"

git add .
git commit -m $msg
git push
