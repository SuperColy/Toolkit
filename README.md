# 🛠️ CyberColy's Toolkit v2.1

Un toolkit potente e leggero basato su PowerShell per l'ottimizzazione e la manutenzione di Windows 11. Sviluppato appositamente per la gestione rapida di sistema, rete e hardware.

## 🚀 Funzionalità Principali
- **Dashboard Hardware**: Visualizzazione in tempo reale di CPU, RAM e spazio su SSD (C:).
- **Manutenzione Disco**: Pulizia profonda dei file temporanei di sistema.
- **Gestione Energia**: Switch rapido tra modalità Risparmio e Prestazioni Elevate.
- **Sicurezza**: Avvio rapido di scansioni Windows Defender.
- **Diagnostica Batteria**: Generazione automatica del report salute della batteria sul Desktop.

## 💻 Requisiti
- Windows 10 o Windows 11.
- PowerShell 5.1 o superiore.
- Permessi di Amministratore (il toolkit li richiederà automaticamente).

## ⚙️ Installazione e Uso
1. Scarica il file `CyberColyToolkit.ps1`.
2. Fai tasto destro sul file e seleziona **"Esegui con PowerShell"**.
   - *Nota: Se è la prima volta, potresti dover abilitare l'esecuzione degli script con `Set-ExecutionPolicy RemoteSigned`.*

## 🛠️ Come compilare in EXE
Se vuoi creare il tuo eseguibile personale come ho fatto io:
1. Installa il modulo: `Install-Module ps2exe`.
2. Compila: `Invoke-PS2EXE .\CyberColyToolkit.ps1 .\CyberColyToolkit.exe -noConsole -iconFile .\tua_icona.ico`.

---
*Creato con ❤️ da CyberColy per Christianbronx.*
