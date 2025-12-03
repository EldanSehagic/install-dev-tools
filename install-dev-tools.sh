#!/bin/bash

echo "===== PROVJERAVANJE / INSTALIRANJE DEVELOPMENT ALATA ====="


check_installed() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "[OK] $1 je već instaliran."
        return 0
    else
        return 1
    fi
}

echo "Provjera dostupnosti WINGET..."
if ! command -v winget >/dev/null 2>&1; then
    echo "[GREŠKA] winget nije dostupan na sistemu. Ažuriraj Windows 10 (21H2+) ili instaliraj App Installer."
    exit 1
fi

# ------------------ NODE.JS ------------------
echo "Provjera Node.js..."
if check_installed node; then
    node -v
else
    echo "Instaliram Node.js (zadnja verzija)..."
    winget install OpenJS.NodeJS -h --accept-source-agreements --accept-package-agreements
fi

# ------------------ NPM ------------------
echo "Provjera npm..."
if check_installed npm; then
    npm -v
else
    echo "NPM dolazi sa Node.js – provjeravam ponovno instalaciju Node-a..."
    winget install OpenJS.NodeJS -h --accept-source-agreements --accept-package-agreements
fi

# ------------------ EXPRESS (GLOBAL) ------------------
echo "Provjera Express.js..."
if npm list -g express >/dev/null 2>&1; then
    echo "[OK] express.js je već instaliran globalno."
else
    echo "Instaliram express globalno..."
    npm install -g express
fi

# ------------------ POSTMAN ------------------
echo "Provjera Postman..."
if winget list | grep -qi "Postman"; then
    echo "[OK] Postman je već instaliran."
else
    echo "Instaliram Postman..."
    winget install Postman.Postman -h --accept-package-agreements --accept-source-agreements
fi

# ------------------ WEBSTORM ------------------
echo "Provjera WebStorm..."
if winget list | grep -qi "WebStorm"; then
    echo "[OK] WebStorm je već instaliran."
else
    echo "Instaliram WebStorm..."
    winget install JetBrains.WebStorm -h --accept-package-agreements --accept-source-agreements
fi

echo "====================================================="
echo "Instalacija završena."
echo "====================================================="
