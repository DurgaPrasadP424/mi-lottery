const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electronAPI', {
  // Save CSV file via native dialog
  saveCSV: (csvContent, defaultName) =>
    ipcRenderer.invoke('save-csv', csvContent, defaultName),

  // Listen for menu events
  onMenuExportCSV: (callback) =>
    ipcRenderer.on('menu:export-csv', callback),
});
