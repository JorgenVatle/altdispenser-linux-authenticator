'use strict'

const {app, BrowserWindow} = require("electron");
const path = require("path");
const url = require("url");

let win; // Store a reference to the BrowserWindow object in order to not have it be garbage collected.

function createWindow() {
    win = new BrowserWindow({width: 600, height: 200});
    win.setMenuBarVisibility(false);

    win.loadURL(url.format({
        pathname: path.join(__dirname, "index.html"),
        protocol: 'file',
        slashes: true
    }));

    // win.webContents.openDevTools();

    win.on("closed", () => {
        win = null; // Dereference, garbage collect 'win' object.
    });
}

app.on("ready", createWindow);

app.on("window-all-closed", () => {
    app.quit();
});
